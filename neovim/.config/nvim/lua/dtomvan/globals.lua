P = function(v)
    print(vim.inspect(v))
    return v
end

local ok, reload = pcall(require, 'plenary.reload')
RELOAD = function(...)
    if ok then
        return require('plenary.reload').reload_module(...)
    else
        return
    end
end

R = function(name)
    RELOAD(name)
    return require(name)
end

EX = setmetatable({}, {
    __index = function(t, k)
        local command = k:gsub('_$', '!')
        ---@type function
        local f

        if vim.fn.has 'nvim-0.8' == 1 then
            f = vim.cmd[command]
        else
            f = function(...)
                return vim.api.nvim_command(
                    table.concat(vim.tbl_flatten { command, ... }, ' ')
                )
            end
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
