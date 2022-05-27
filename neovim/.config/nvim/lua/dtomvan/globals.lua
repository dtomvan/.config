P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require('plenary.reload').reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

EX = setmetatable({}, {
    __index = function(t, k)
        local command = k:gsub('_$', '!')
        local f = function(...)
            return vim.api.nvim_command(table.concat(vim.tbl_flatten { command, ... }, ' '))
        end
        rawset(t, k, f)
        return f
    end,
})

-- Access the globals through a module as well
local M = {}
M.R = R
M.RELOAD = RELOAD
M.P = P
M.EX = EX
return M
