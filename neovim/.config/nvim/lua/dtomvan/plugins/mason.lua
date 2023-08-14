return {
    {
        'williamboman/mason.nvim',
        event = 'VeryLazy',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/lsp_extensions.nvim',
            { 'folke/neodev.nvim',  opts = {} },
            { 'folke/neoconf.nvim', opts = {} },
        },
        config = function()
            require('mason').setup()
            require 'dtomvan.lsp'
        end,
    },

    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        opts = {},
    },
    { 'simrat39/rust-tools.nvim', lazy = true },
}
