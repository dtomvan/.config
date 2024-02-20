return {
    {
        'tjdevries/nlua.nvim',
        lazy = true,
        dependencies = 'L3MON4D3/LuaSnip',
    },
    {
        'SmiteshP/nvim-navbuddy',
        cond = function()
            return pcall(require, 'nvim-navic')
        end,
        event = 'LspAttach',
        dependencies = {
            'neovim/nvim-lspconfig',
            'MunifTanjim/nui.nvim',
        },
    },
}
