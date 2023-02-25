return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'f3fora/cmp-spell',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-omni',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',
        'onsails/lspkind-nvim',
        'petertriho/cmp-git',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        require 'dtomvan.config.cmp'
    end,
    event = { 'InsertEnter', 'CmdlineEnter' },
}
