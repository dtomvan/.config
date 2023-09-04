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
            draw = {
                animation = function() return 0 end,
            },
        },
    },
    {
        'echasnovski/mini.bracketed',
        version = '*',
        event = 'VeryLazy',
        config = mini_req,
        opts = {
            buffer = { suffix = '' },
        },
    },
    {
        'echasnovski/mini.clue',
        version = '*',
        event = 'UIEnter',
        config = mini_req,
        opts = function()
            local clue = require('mini.clue')
            return {
                window = {
                    config = {
                        anchor = 'SW',
                        row = 'auto',
                        col = 'auto',
                        width = 'auto',
                    },
                },
                triggers = {
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },
                    { mode = 'i', keys = '<C-x>' },
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },
                    { mode = 'n', keys = '<C-w>' },
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    { mode = 'n', keys = '<Leader>c',  desc = '+Terminal' },
                    { mode = 'n', keys = '<Leader>d',  desc = '+Dot' },
                    { mode = 'n', keys = '<Leader>f',  desc = '+Find' },
                    { mode = 'n', keys = '<Leader>g',  desc = '+Goto' },
                    { mode = 'n', keys = '<Leader>gf', desc = '+file' },
                    { mode = 'n', keys = '<Leader>r',  desc = '+Re...' },
                    { mode = 'n', keys = '<Leader>t',  desc = '+Transpose/Term' },
                    { mode = 'n', keys = '<Leader>w',  desc = '+LSP Workspace' },
                    clue.gen_clues.builtin_completion(),
                    clue.gen_clues.g(),
                    clue.gen_clues.marks(),
                    clue.gen_clues.registers(),
                    clue.gen_clues.windows(),
                    clue.gen_clues.z(),
                },
            }
        end,
    },
}
