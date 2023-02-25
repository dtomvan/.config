if vim.g._no_noice or vim.g.goneovim == 1 then
    return
end
require('noice').setup {
    presets = {
        bottom_search = true,
    },
    cmdline = {
        view = 'cmdline',
        format = {
            cmdline = { pattern = '^:', lang = 'vim', icon = '>' },
            telescope = { pattern = '^:Telescope ', lang = '', icon = '󰭎' },
        },
    },
    routes = {
        {
            filter = { event = 'msg_show', find = '(mini.starter)' },
            opts = { skip = true },
        },
        {
            filter = { event = 'msg_show', find = '<bs> go up one level <esc> close' },
            opts = { skip = true },
        },
        {
            view = 'split',
            filter = { event = 'msg_show', min_height = 10 },
        },
        {
            view = 'mini',
            filter = {
                event = 'msg_show',
                kind = '',
                find = 'written',
            },
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
    popupmenu = {
        enabled = false,
    },
    lsp = {
        progress = {
            format = {
                {
                    '{progress} ',
                    key = 'progress.percentage',
                    contents = {
                        -- { "{data.progress.message} " },
                    },
                },
                { '{spinner} ', hl_group = 'NoiceLspProgressSpinner' },
                { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
            },
            format_done = {
                { '✔ ', hl_group = 'NoiceLspProgressSpinner' },
                { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
            },
        },
        override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
        },
    },
}
