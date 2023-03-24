return {
    {
        'nvim-telescope/telescope.nvim',
        keys = {
            '<c-p>',
            '<leader>B',
            '<leader>dd',
            '<leader>fb',
            '<leader>fp',
            '<leader>q',
            '<leader>:',
            '<m-x>',
            '<leader>ft',
            '<C-e>',
            '<leader>h',
            '<leader>h',
            '<leader>?',
            '<leader>/',
            '<leader>;',
            '<leader>T',
        },
        cmd = 'Telescope',
        config = CONF.telescope,
    },
    'nvim-telescope/telescope-symbols.nvim',
    {
        'nvim-telescope/telescope-fzy-native.nvim',
        lazy = true,
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        lazy = true,
        keys = {
            {
                '<leader>pv',
                function()
                    require('telescope').extensions.file_browser.file_browser()
                end,
            },
        },
    },
 }
