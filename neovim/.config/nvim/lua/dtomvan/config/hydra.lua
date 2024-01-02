local M = {}

M.setup = function(config)
    local mode = (type(config.mode) == 'table' or type(config.mode) == 'string')
        and config.mode
        or error 'Invalid mode'
    local key = type(config.body) == 'string' and config.body
        or error 'Invalid hydra body'

    ---@cast mode string
    ---@cast key string
    vim.keymap.set(mode, key, function()
        require 'hydra' (config):activate()
    end, { desc = config.name .. ' Hydra' })
end

-- Don't want to do more lazy-loading shenanigans for this eensy function
M.key_cmd = function(cmd)
    return ('<cmd>%s<cr>'):format(cmd)
end

M.o = function(map, cmd)
    return { map, ':' .. cmd .. ' ', { exit = true, desc = cmd } }
end

return M
