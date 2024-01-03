return {
    {
        'tjdevries/nlua.nvim',
        lazy = true,
        dependencies = 'L3MON4D3/LuaSnip',
    },
    {
        'SmiteshP/nvim-navbuddy',
        event = 'LspAttach',
        dependencies = {
            'neovim/nvim-lspconfig',
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
        },
    },
}
