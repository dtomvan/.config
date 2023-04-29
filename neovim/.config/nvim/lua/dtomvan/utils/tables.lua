--- @class TableUtils
--- @field filter_endswith function
--- @field filter_eq function
--- @field filter_startswith function
--- @field get_filter_endswith fun(table:table,idx:any,what:any): table
--- @field get_filter_eq fun(table:table,idx:any,what:any): table
--- @field get_filter_startswith fun(table:table,idx:any,what:any): table
--- @field iter_all function
--- @field iter_any function
--- @field iter_filter_endswith function
--- @field iter_filter_eq function
--- @field iter_filter_startswith function
--- @field iter_fold function
--- @field iter_get_filter_endswith fun(iter:Iter,idx:any,what:any): table
--- @field iter_get_filter_eq fun(iter:Iter,idx:any,what:any): table
--- @field iter_get_filter_startswith fun(iter:Iter,idx:any,what:any): table
--- @field iter_map_filter_endswith function
--- @field iter_map_filter_eq function
--- @field iter_map_filter_startswith function
--- @field iter_map_get function
--- @field iter_multi_get_filter_endswith fun(iter:Iter,idx:any,what:any): table
--- @field iter_multi_get_filter_eq fun(iter:Iter,idx:any,what:any): table
--- @field iter_multi_get_filter_startswith fun(iter:Iter,idx:any,what:any): table
--- @field iter_multi_get function
--- @field iter_multi_map_get function
--- @field iter_multi_peek_filter_endswith fun(iter:Iter,idx:any,what:any): table
--- @field iter_multi_peek_filter_eq fun(iter:Iter,idx:any,what:any): table
--- @field iter_multi_peek_filter_startswith fun(iter:Iter,idx:any,what:any): table
--- @field iter_peek_filter_endswith fun(iter:Iter,idx:any,what:any): table
--- @field iter_peek_filter_eq fun(iter:Iter,idx:any,what:any): table
--- @field iter_peek_filter_startswith fun(iter:Iter,idx:any,what:any): table
--- @field map_filter_endswith function
--- @field map_filter_eq function
--- @field map_filter_startswith function
--- @field multi_get_filter_endswith fun(table:table,idx:any,what:any): table
--- @field multi_get_filter_eq fun(table:table,idx:any,what:any): table
--- @field multi_get_filter_startswith fun(table:table,idx:any,what:any): table
--- @field multi_peek_filter_endswith fun(table:table,idx:any,what:any): table
--- @field multi_peek_filter_eq fun(table:table,idx:any,what:any): table
--- @field multi_peek_filter_startswith fun(table:table,idx:any,what:any): table
--- @field peek_filter_endswith fun(table:table,idx:any,what:any): table
--- @field peek_filter_eq fun(table:table,idx:any,what:any): table
--- @field peek_filter_startswith fun(table:table,idx:any,what:any): table
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

local iter_funcs = {}
for k, v in pairs(M) do
    iter_funcs['iter_' .. k] = function(iter, ...)
        local item = v(iter:totable() or {}, ...)
        return type(item) == 'table' and vim.iter(item) or item
    end
end

---@return TableUtils
return vim.tbl_extend('error', M, iter_funcs)
