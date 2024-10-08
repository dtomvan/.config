return {
    {
        'williamboman/mason.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/lsp-status.nvim',
            'neovim/nvim-lspconfig',
            'nvim-lua/lsp_extensions.nvim',
        },
        config = function()
            require('mason').setup()
            require 'dtomvan.lsp'
        end,
        init = function()
            for k, v in pairs(require 'mason.api.command') do
                vim.api.nvim_create_user_command(k, function(opts)
                    v(opts.fargs or {})
                end, { nargs = '*' })
            end
        end
    },

    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        opts = {},
    },
    { 'simrat39/rust-tools.nvim', lazy = true },
    { 'folke/neodev.nvim',        lazy = true, opts = {} },
    { 'folke/neoconf.nvim',       lazy = true, config = false },
}
