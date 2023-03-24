return {
    -- {
    --     'echasnovski/mini.pairs',
    --     config = function()
    --         require('mini.pairs').setup {}
    --     end,
    --     event = 'VeryLazy',
    -- },
    {
        'echasnovski/mini.starter',
        dependencies = {
            'dtomvan/starter-birthday.nvim',
            opts = {
                username = 'Tom',
                date = {
                    day = 20,
                    month = 12,
                },
            },
        },
        config = CONF.starter,
    },
    {
        'echasnovski/mini.sessions',
        config = CONF.sessions,
    },
    {
        'echasnovski/mini.bufremove',
        keys = {
            {
                '<leader>bd',
                function()
                    require('mini.bufremove').delete(0, false)
                end,
                desc = 'Delete Buffer',
            },
            {
                '<leader>bD',
                function()
                    require('mini.bufremove').delete(0, true)
                end,
                desc = 'Delete Buffer (Force)',
            },
        },
    },
}
