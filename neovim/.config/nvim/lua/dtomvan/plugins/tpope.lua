return {
    {
        'tpope/vim-surround',
        keys = {
            { 'ds' },
            { 'cs' },
            { 'cS' },
            { 'ys' },
            { 'yS' },
            { 'yss' },
            { 'ySs' },
            { 'ySS' },
            { 'S',      mode = 'x' },
            { 'gS',     mode = 'x' },
            { '<c-s>',  mode = 'i' },
            { '<c-g>s', mode = 'i' },
            { '<c-g>S', mode = 'i' },
        },
    },
    'tpope/vim-eunuch',
    {
        'tummetott/unimpaired.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    'tpope/vim-repeat',
    { 'tpope/vim-fugitive', cmd = 'G' },
    {
        'tpope/vim-sleuth',
        event = 'BufReadPost',
    },
    {
        'tpope/vim-endwise',
        enabled = not (vim.fn.has 'nvim-0.8' == 1),
        event = 'BufReadPost',
    },
}
