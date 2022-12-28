return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',
        'f3fora/cmp-spell',
        'onsails/lspkind-nvim',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        require 'dtomvan.config.cmp'
    end,
    event = "InsertEnter",
}
