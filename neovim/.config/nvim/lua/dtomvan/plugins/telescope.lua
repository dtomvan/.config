return {
    -- TJ telescope Johnson
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
        config = function()
            require 'dtomvan.config.telescope'
        end,
    },
    'nvim-telescope/telescope-fzy-native.nvim',
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
