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
            { 'S', mode = 'x' },
            { 'gS', mode = 'x' },
            { '<c-s>', mode = 'i' },
            { '<c-g>s', mode = 'i' },
            { '<c-g>S', mode = 'i' },
        }
    },
    'tpope/vim-eunuch',
    {
        'tpope/vim-unimpaired',
        event = 'InsertEnter',
    },
    {
        'tpope/vim-repeat',
        keys = { 'u', 'U', '.', '<c-r>' },
    },
    { 'tpope/vim-fugitive', cmd = 'G' },
    {
        'tpope/vim-sleuth',
        event = 'BufReadPost',
    },
    {
        'tpope/vim-endwise',
        event = 'BufReadPost',
    },
}
