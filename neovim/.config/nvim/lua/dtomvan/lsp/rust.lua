local opts = require 'dtomvan.lsp.opts'

return {
    tools = {
        autoSetHints = true,
        executor = function(...)
            require('rust-tools/executors').termopen(...)
        end,
        runnables = {
            use_telescope = true,
        },
        debuggables = {
            use_telescope = true,
        },
        inlay_hints = {
            only_current_line = true,
            only_current_line_autocmd = 'CursorMoved',
            show_parameter_hints = true,
            parameter_hints_prefix = '<- ',
            other_hints_prefix = '=> ',
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = 'Comment',
        },
        hover_actions = {
            border = {
                { '╭', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '╮', 'FloatBorder' },
                { '│', 'FloatBorder' },
                { '╯', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '╰', 'FloatBorder' },
                { '│', 'FloatBorder' },
            },
            auto_focus = false,
        },
        crate_graph = {
            backend = 'x11',
            output = nil,
            full = true,
        },
    },
    server = {
        on_attach = function(...)
            opts.on_attach(...)
            vim.keymap.set(
                'n',
                'K',
                '<cmd>RustHoverActions<cr>',
                { buffer = true, desc = 'Rust hover actions' }
            )
        end,
        standalone = true,
        capabilities = opts.capabilities,
        settings = {
            ['rust-analyzer'] = {
                diagnostics = { disabled = { 'inactive-code' } },
            },
        },
    },
}
