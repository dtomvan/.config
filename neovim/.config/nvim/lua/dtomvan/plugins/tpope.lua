return {
    {
        'tpope/vim-repeat',
        event = 'VeryLazy',
    },
    'tpope/vim-sleuth',
    {
        'tpope/vim-endwise',
        enabled = not (vim.fn.has 'nvim-0.8' == 1),
        event = 'BufReadPost',
    },
}
