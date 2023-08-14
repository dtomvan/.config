return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/nvim-cmp',
            'onsails/lspkind-nvim',
            'petertriho/cmp-git',
            'saadparwaiz1/cmp_luasnip',
        },
        config = CONF.cmp,
        event = 'InsertEnter',
    },
    {
        'L3MON4D3/LuaSnip',
        event = 'BufReadPost',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function()
            vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
                group = vim.api.nvim_create_augroup(
                    'LuaSnipConf',
                    { clear = true }
                ),
                once = true,
                callback = CONF.luasnip,
            })
        end,
    },
}
