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
    {
        'tpope/vim-repeat',
        event = 'VeryLazy',
    },
    { 'tpope/vim-fugitive', cmd = 'G' },
    'tpope/vim-sleuth',
    {
        'tpope/vim-endwise',
        enabled = not (vim.fn.has 'nvim-0.8' == 1),
        event = 'BufReadPost',
    },
}
