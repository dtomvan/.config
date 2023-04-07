local utils = require 'dtomvan.utils'
local tables = require 'dtomvan.utils.tables'

return {
    'nvim-pack/nvim-spectre',
    build = './build.sh',
    keys = {
        {
            '<leader>gS',
            '<cmd>=require("spectre").open()<CR>',
            mode = 'n',
            desc = 'Open Spectre',
        },
        {
            '<leader>gsw',
            '<cmd>=require("spectre").open_visual{select_word=true}<CR>',
            mode = 'n',
            desc = 'Search current word',
        },
        {
            '<leader>gsw',
            '<esc><cmd>=require("spectre").open_visual()<CR>',
            mode = 'v',
            desc = 'Search current word',
        },
        {
            '<leader>gsp',
            '<cmd>=require("spectre").open_file_search{select_word=true}<CR>',
            mode = 'n',
            desc = 'Search on current file',
        },
    },
    opts = function()
        local replacer
        local fname

        if vim.loop.os_uname().sysname == 'Windows_NT' then
            fname = 'lua/spectre_oxi.dll'
        else
            fname = 'lua/spectre_oxi.so'
        end

        if
            tables.any(
                vim.api.nvim_get_runtime_file(fname, true),
                utils.pred_and(vim.fn.filereadable, function(f)
                    return package.loadlib(f, 'luaopen_spectre_oxi')
                end)
            )
        then
            replacer = 'oxi'
        else
            replacer = 'sed'
        end

        return {
            default = {
                replace = {
                    cmd = replacer,
                },
            },
        }
    end,
}
