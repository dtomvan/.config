return {
    'ghillb/cybu.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
    },
    cmd = 'Cybu',
    config = {
        style = {
            highlights = {
                current_buffer = 'CybuFocus',
                adjacent_buffers = 'NormalFloat',
                background = 'NormalFloat',
                border = 'WinSeparator',
            },
        },
    },
    keys = {
        {
            '<s-tab>',
            '<cmd>Cybu prev<cr>',
            { 'n', 'v' },
        },
        {
            '<tab>',
            '<cmd>Cybu next<cr>',
            { 'n', 'v' },
        },
    },
}