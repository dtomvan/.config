return {
    'folke/noice.nvim',
    event = 'VimEnter',
    opts = {
        presets = {
            bottom_search = true,
        },
        cmdline = {
            view = 'cmdline',
            format = {
                cmdline = { conceal = true, icon = 'Noice >' },
                filter = false,
                lua = false,
                help = false,
            },
        },
        routes = {
            {
                view = 'mini',
                filter = {
                    event = "msg_showmode",
                    find = 'recording',
                },
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
            -- FIXME: for some reason this displays the message both as a notify
            -- and as a mini...
            -- {
            --     filter = {
            --         event = 'msg_show',
            --         kind = '',
            --         max_height = 2,
            --         max_length = 60,
            --     },
            --     view = 'mini',
            -- },
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
                        contents = {
                            -- { "{data.progress.message} " },
                        },
                    },
                    -- { '{spinner} ', hl_group = 'NoiceLspProgressSpinner' },
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
