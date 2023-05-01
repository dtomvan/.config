local function mini_req(plug, opts)
    local sp = vim.split(plug[1], '.', { plain = true })
    require('mini.' .. sp[#sp]).setup(opts)
end

return {
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
    {
        'echasnovski/mini.indentscope',
        version = '*',
        event = 'FileType',
        config = mini_req,
        opts = {
            symbol = '│',
        },
    },
    {
        'echasnovski/mini.bracketed',
        version = '*',
        event = 'VeryLazy',
        config = mini_req,
    },
}
