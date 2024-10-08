return {
    'folke/noice.nvim',
    enabled = false,
    event = 'VimEnter',
    opts = {
        presets = {
            command_palette = true,
        },
        notify = {
            view = 'mini',
        },
        cmdline = {
            view = 'cmdline_popup',
            format = {
                cmdline = {
                    conceal = true,
                    icon = '->',
                    title = '',
                },
                filter = false,
                lua = false,
                help = false,
                search_down = {
                    view = "cmdline_popup",
                    icon = '/',
                    title = '',
                },
                search_up = {
                    view = "cmdline_popup",
                    icon = '/',
                    title = '',
                },
            },
        },
        routes = {
            {
                view = 'mini',
                filter = {
                    event = "msg_showmode",
                },
            },
            {
                view = 'split',
                filter = { event = 'msg_show', min_height = 5 },
            },
            {
                view = 'mini',
                filter = {
                    event = 'msg_show',
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                        { find = "fewer lines" },
                        {
                            kind = '',
                            find = 'written',
                        },
                    },
                },
            },
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    max_height = 5,
                    max_length = 60,
                },
                view = 'mini',
            },
            {
                filter = { event = 'msg_show', find = '(mini.starter)' },
                opts = { skip = true },
            },
            {
                filter = {
                    event = 'msg_show',
                    find = '<bs> go up one level <esc> close',
                },
                opts = { skip = true },
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
                border = {
                    style = "none",
                    padding = { 1, 1 },
                },
                win_options = {
                    winhighlight = {
                        NormalFloat = "NormalFloat",
                        FloatBorder = "FloatBorder"
                    },
                    winblend = 30,
                },
            },
            cmdline_popupmenu = {
                border = {
                    style = "none",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = {
                        NormalFloat = "NormalFloat",
                        FloatBorder = "NoiceCmdlinePopupBorder"
                    },
                    winblend = 30,
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
                    winhighlight = {
                        Normal = 'Normal',
                        FloatBorder = 'DiagnosticInfo',
                    },
                },
            },
        },
        popupmenu = {
            enabled = true,
        },
        lsp = {
            progress = {
                format = {
                    {
                        '{progress} ',
                        key = 'progress.percentage',
                        contents = {},
                    },
                    {
                        '{data.progress.client} ',
                        hl_group = 'NoiceLspProgressClient',
                    },
                },
                format_done = {
                    { '✔ ', hl_group = 'NoiceLspProgressSpinner' },
                    {
                        '{data.progress.client} ',
                        hl_group = 'NoiceLspProgressClient',
                    },
                },
            },
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
        },
    },
    dependencies = {
        'nvim-lua/lsp-status.nvim',
        'MunifTanjim/nui.nvim',
    },
    cond = vim.g.started_by_firenvim == nil
        and vim.g.neovide == nil
        and not vim.g._no_noice
        and vim.g.goneovim ~= 1,
}
