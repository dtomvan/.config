return {
    {
        'williamboman/mason.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/lsp_extensions.nvim',
            { 'folke/neodev.nvim',  opts = {} },
            { 'folke/neoconf.nvim', opts = {} },
        },
        config = function()
            require('mason').setup()
            local group =
                vim.api.nvim_create_augroup('RequireUserLsp', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
                callback = function()
                    require 'dtomvan.lsp'
                end,
                once = true,
                group = group,
            })
        end,
    },

    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        opts = {},
    },

    {
        'jay-babu/mason-null-ls.nvim',
        lazy = true,
        opts = {
            automatic_setup = true,
        },
    },
}
