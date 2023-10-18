local func = require 'dtomvan.utils.func'

-- BEWARE: This is a major hack and just meant as an easy but inperformant
-- solution to all your lua list-shaped table shenanigans
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

function M.map_idx(tbl, tbl_2)
    return vim.tbl_map(function(x)
        return tbl_2[x]
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
        return vim.tbl_filter(func.set_nth(use, what, 2), tbl)
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
    for _, i in ipairs {
        '',
        'map_',
        'get_',
        'multi_get_',
        'peek_',
        'multi_peek_',
        'map_peek_',
        'multi_map_peek_',
    } do
        M[i .. 'find_' .. fn] = function(...)
            return M[i .. filter](...)[1]
        end
        M[i .. 'count_' .. fn] = function(...)
            return #M[i .. filter](...)
        end
        M[i .. 'filter_not_' .. fn] = function(tbl, x, y)
            -- FIXME: This is the relevant hacky imperformant code I mentioned before.
            local remove = M[i .. filter](tbl, x, y)
            return vim.tbl_filter(
                function(el)
                    return not vim.tbl_contains(remove, el)
                end,
                tbl
            )
        end
        M[i .. 'find_not_' .. fn] = function(...)
            return M[i .. 'filter_not_' .. fn](...)[1]
        end
        M[i .. 'count_not_' .. fn] = function(...)
            return #M[i .. 'filter_not_' .. fn](...)
        end
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

---@return TableUtils
return M
