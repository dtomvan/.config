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

-- Access the globals through a module as well
local M = {}
M.R = R
M.RELOAD = RELOAD
M.P = P
return M
