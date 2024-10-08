return {
    {
        'tjdevries/nlua.nvim',
        lazy = true,
        dependencies = 'L3MON4D3/LuaSnip',
    },
    {
        'SmiteshP/nvim-navbuddy',
        enabled = false,
        cond = function()
            return pcall(require, 'nvim-navic')
        end,
        event = 'LspAttach',
        dependencies = {
            'neovim/nvim-lspconfig',
            'MunifTanjim/nui.nvim',
        },
    },
    {
        'ziglang/zig.vim',
        lazy = true,
        ft = 'zig',
        dependencies = {'folke/neoconf.nvim', 'williamboman/mason.nvim' },
        config = function()
            -- don't show parse errors in a separate window
            vim.g.zig_fmt_parse_errors = 0
            -- disable format-on-save from `ziglang/zig.vim`
            vim.g.zig_fmt_autosave = 0

            vim.cmd [[autocmd BufWritePre *.zig lua vim.lsp.buf.format()]]

            local lspconfig = require('lspconfig')
            local on_attach = require 'dtomvan.lsp.attach_handler'
            lspconfig.zls.setup {
                on_attach = on_attach,
                zls = {
                }
            }
        end,
    }
}
