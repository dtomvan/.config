local M = {}

---@param tbl table
---@return any | nil
function M.multi_get(tbl, idx)
    local a = tbl
    for _, i in ipairs(idx) do
        if not a then
            break
        end
        a = a[i]
    end
    return a
end

---@param tbl table
---@return table
function M.map_get(tbl, idx)
    return vim.tbl_map(function(x)
        return x[idx]
    end, tbl)
end

---@param tbl table
---@return table
function M.multi_map_get(tbl, idx)
    return vim.tbl_map(function(x)
        return M.multi_get(x, idx)
    end, tbl)
end

-- filter_endswith
-- filter_eq
-- filter_startswith
-- get_filter_endswith
-- get_filter_eq
-- get_filter_startswith
-- map_filter_endswith
-- map_filter_eq
-- map_filter_startswith
-- multi_get_filter_endswith
-- multi_get_filter_eq
-- multi_get_filter_startswith
-- multi_peek_filter_endswith
-- multi_peek_filter_eq
-- multi_peek_filter_startswith
-- peek_filter_endswith
-- peek_filter_eq
-- peek_filter_startswith
for _, fn in ipairs { 'startswith', 'endswith', 'eq' } do
    local use = vim[fn]
    if fn == 'eq' then
        use = function(a, b)
            return a == b
        end
    end
    local filter = 'filter_' .. fn

    ---@param tbl any[]
    ---@param what any
    ---@return any[]
    M[filter] = function(tbl, what)
        return vim.tbl_filter(function(x)
            return use(x, what)
        end, tbl)
    end

    ---@param tbl table
    ---@param map fun(any): boolean
    ---@return table
    M['map_' .. filter] = function(tbl, map, what)
        return M[filter](vim.tbl_map(map, tbl), what)
    end

    ---@param tbl table
    ---@return table
    M['get_' .. filter] = function(tbl, idx, what)
        return M[filter](M.map_get(tbl, idx), what)
    end

    ---@param tbl table
    ---@return table
    M['multi_get_' .. filter] = function(tbl, idx, what)
        return M[filter](M.multi_map_get(tbl, idx), what)
    end

    ---@param tbl table
    ---@return table
    M['peek_' .. filter] = function(tbl, idx, what)
        return vim.tbl_filter(function(x)
            return use(x[idx], what)
        end, tbl)
    end

    ---@param tbl table
    ---@return table
    M['multi_peek_' .. filter] = function(tbl, idx, what)
        return vim.tbl_filter(function(x)
            return use(M.multi_get(x, idx), what)
        end, tbl)
    end
end

return M
