local M = {}

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

function M.map_get(tbl, idx)
    return vim.tbl_map(function(x)
        return x[idx]
    end, tbl)
end

function M.multi_map_get(tbl, idx)
    return vim.tbl_map(function(x)
        return M.multi_get(x, idx)
    end, tbl)
end

for _, fn in ipairs { 'tbl_contains', 'startswith', 'endswith', 'eq' } do
    local use = vim[fn]
    if fn == 'eq' then
        use = function(a, b)
            return a == b
        end
    end
    local filter = 'filter_' .. fn

    M[filter] = function(tbl, what)
        return vim.tbl_filter(function(x)
            return use(x, what)
        end, tbl)
    end

    M['map_' .. filter] = function(tbl, map, what)
        return M[filter](vim.tbl_map(map, tbl), what)
    end

    M['get_' .. filter] = function(tbl, idx, what)
        return M[filter](M.map_get(tbl, idx), what)
    end

    M['multi_get_' .. filter] = function(tbl, idx, what)
        return M[filter](M.multi_map_get(tbl, idx), what)
    end

    M['peek_' .. filter] = function(tbl, idx, what)
        return vim.tbl_filter(function(x)
            return use(x[idx], what)
        end, tbl)
    end

    M['multi_peek_' .. filter] = function(tbl, idx, what)
        return vim.tbl_filter(function(x)
            return use(M.multi_get(x, idx), what)
        end, tbl)
    end

    M['map_peek_' .. filter] = function(tbl, map, what)
        return vim.tbl_filter(function(x)
            return use(map(x), what)
        end, tbl)
    end

    M['multi_map_peek_' .. filter] = function(tbl, maps, what)
        local iter = vim.iter(vim.tbl_filter(function(x)
            return use(maps[1](x), what)
        end, tbl))
        for i, map in ipairs(maps) do
            if i == 1 then goto continue end
            iter = iter:map(map)
            ::continue::
        end
        return iter:totable()
    end
end

function M.fold(tbl, init, predicate)
    local accumulator = init
    for _, i in ipairs(tbl) do
        accumulator = predicate(accumulator, i)
    end
end

function M.any(tbl, predicate)
    for _, i in ipairs(tbl) do
        if predicate(i) then
            return true
        end
    end
    return false
end

function M.all(tbl, predicate)
    for _, i in ipairs(tbl) do
        if not predicate(i) then
            return false
        end
    end
    return true
end

-- TODO: Actually use iterator pipeline correctly (filters using :filter(...))
local iter_funcs = {}
for k, v in pairs(M) do
    iter_funcs['iter_' .. k] = function(iter, ...)
        local item = v(iter:totable() or {}, ...)
        return type(item) == 'table' and vim.iter(item) or item
    end
end

---@return TableUtils
return vim.tbl_extend('error', M, iter_funcs)
