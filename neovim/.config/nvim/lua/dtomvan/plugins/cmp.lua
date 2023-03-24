return {
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
}
