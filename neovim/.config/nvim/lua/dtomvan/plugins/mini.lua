local mini = require 'dtomvan.utils.mini_plug_helper'.mini

return {
    mini('starter', {
        enabled = false,
        config = true,
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
    }),
    mini('sessions', { config = true }),
    mini('bufremove', {
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
    }),
    mini('indentscope', {
        event = 'FileType',
        opts = {
            symbol = '│',
            draw = {
                animation = function() return 0 end,
            },
        },
    }),
    mini('bracketed', {
        event = 'VeryLazy',
        opts = {
            buffer = { suffix = '' },
        },
    }),
    mini('surround', {
        opts = {
            mappings = {
                add = "ys",
                delete = "ds",
                replace = "cs",
            },
        },
    }),
    mini('clue', {
        config = true,
        event = 'UIEnter',
    }),
    mini('tabline', {
        opts = {
            set_vim_settings = false,
            tabpage_section = 'right',
        }
    }),
    mini('align', {
        commit = '68a8d3205f0e7ce1bded057f4a851f42ef8fc584',
    }),
    mini('files', {
        opts = {
            options = {
                permanent_delete = false,
            },
            windows = {
                max_number = 3
            },
        },
        keys = {
            { "-", function() MiniFiles.open() end },
        }
    }),
    mini('hipatterns', {
        commit = '427712c754bfdccd8da7073576cd8e2586c0fe93',
        config = true,
    }),
    mini('move', {
        event = 'InsertEnter',
        keys = {
            { mode = 'v', '<M-h>' },
            { mode = 'v', '<M-j>' },
            { mode = 'v', '<M-k>' },
            { mode = 'v', '<M-l>' },
        },
        config = true,
    }),
    mini('splitjoin'),
}
