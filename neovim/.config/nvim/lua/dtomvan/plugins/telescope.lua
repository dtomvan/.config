return {
    -- TJ telescope Johnson
    {
        'nvim-telescope/telescope.nvim',
        keys = {
            '<c-p>',
            '<leader>b',
            '<leader>dd',
            '<leader>fb',
            '<leader>fp',
            '<leader>q',
            '<leader>:',
            '<leader>fc',
            '<leader>ft',
            '<C-e>',
            '<leader>h',
            '<leader>h',
            '<leader>?',
            '<leader>/',
            '<leader>;',
        },
        cmd = 'Telescope',
        config = function()
            require 'dtomvan.config.telescope'
        end,
    },
    'nvim-telescope/telescope-fzy-native.nvim',
}
