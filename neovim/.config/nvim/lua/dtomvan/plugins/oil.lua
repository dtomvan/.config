return {
    'stevearc/oil.nvim',
    config = true,
    keys = {
        {
            '-',
            function()
                require('oil').open()
            end,
            { desc = 'Open parent directory' },
        },
    },
}
