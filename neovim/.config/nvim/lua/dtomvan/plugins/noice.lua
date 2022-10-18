require('noice').setup {
    -- cmdline = {
    --     view = 'cmdline',
    -- },
    routes = {
        {
            view = "split",
            filter = { event = "msg_show", min_height = 20 },
        },
        {
            view = "cmdline",
            filter = { event = "msg_show", find = '<bs> go up one level <esc> close' },
        },
        {
            filter = {
                event = 'msg_show',
                kind = '',
                find = 'written',
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = 'cmdline',
                find = '^%s*[/?]',
            },
            view = 'cmdline',
        },
    },
    views = {
        cmdline_popup = {
            position = {
                row = 6,
                col = '50%',
            },
            size = {
                width = 69,
                height = 'auto',
            },
        },
        popupmenu = {
            relative = 'editor',
            position = {
                row = 9,
                col = '50%',
            },
            size = {
                width = 69,
                height = 10,
            },
            border = {
                style = 'rounded',
                padding = { 0, 1 },
            },
            win_options = {
                winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
            },
        },
    },
}
