local M = {}

---executes both functions in sequence with the same arguments, if any
---collect both results as a table
---@param a function
---@param b function
---@return function(...): { [1]: any, [2]: any }
M.both = function(a, b)
    return function(...)
        return { a(...), b(...) }
    end
end

---executes multiple functions in sequence with the same arguments, if any
---collect all results as a table
---@param ... function
---@return function(...): any[]
M.seq = function(...)
    local funcs = { ... }
    return function(...)
        for i, func in ipairs(funcs) do
            funcs[i] = func(...)
        end
        return funcs
    end
end

---executes multiple functions in sequence with the same arguments, if any
---collect all results anded
---@param ... function(...): boolean
---@return function(...): boolean
M.andd = function(...)
    local funcs = { ... }
    return function(...)
        local res = true
        for _, func in ipairs(funcs) do
            res = func(...) and res
        end
        return res
    end
end

---executes multiple functions in sequence with the same arguments, if any
---collect all results or'ed
---@param ... function(...): boolean
---@return function(...): boolean
M.orr = function(...)
    local funcs = { ... }
    return function(...)
        local res = true
        for _, func in ipairs(funcs) do
            res = func(...) or res
        end
        return res
    end
end

---executes every next function with the previous result in sequence, starting
---with the first arguments
---@generic T
---@param ... function(...): T
---@return function(...): T
M.wrap = function(...)
    local funcs = { ... }
    return function(...)
        local res = ...
        for i, func in ipairs(funcs) do
            res = func(res)
        end
        return res
    end
end

---returns a function which will call with the arguments given
M.set_args = function(func, ...)
    local args = { ... }
    return function()
        return func(unpack(args))
    end
end

M.set_nth = function(func, arg, n)
    return function(...)
        local args = { ... }
        table.insert(args, n, arg)
        return func(unpack(args))
    end
end

M.replace_nth = function(func, arg, n)
    return function(...)
        local args = { ... }
        args[n] = arg
        return func(unpack(args))
    end
end

M.replace_first = function(func, first)
    return M.replace_nth(func, first, 1)
end

M.set_first = function(func, first)
    return M.set_nth(func, first, 1)
end

M.set_multiple = function(func, argv)
    return function(...)
        local args = { ... }
        for k, v in pairs(args) do
            argv[k] = v
        end
        return func(unpack(argv))
    end
end

return M
