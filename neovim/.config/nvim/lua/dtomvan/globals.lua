local M = {}

M.P = function(v)
    print(vim.inspect(v))
    return v
end

M.RELOAD = function(...)
    local ok, reload = pcall(require, 'plenary.reload')
    if ok then
        return reload.reload_module(...)
    else
        error('Plenary not available')
    end
end

M.R = function(name)
    M.RELOAD(name)
    return require(name)
end

M.EX = setmetatable({}, {
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

M.CONF = setmetatable({}, {
    __index = function(_, k)
        return function()
            require('dtomvan.config.' .. k)
        end
    end
})

for k, v in pairs(M) do
    _G[k] = v
end

-- Access the globals through a module as well
return M
