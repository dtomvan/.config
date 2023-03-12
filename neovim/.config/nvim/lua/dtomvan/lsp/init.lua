if vim.g.started_by_firenvim then
    return
end
local mason_lspconfig = require 'mason-lspconfig'
local opts = require 'dtomvan.lsp.opts'

local M = {}

for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
    if
        not (server == 'rome' or server == 'rust_tools' or server == 'lua_ls')
    then
        require('lspconfig')[server].setup(opts)
    end
end

opts.filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
}

require('lspconfig').rome.setup(opts)

local rust_tools, _ = pcall(require, 'rust-tools')
if not rust_tools then
    return
end

-- Rust
local rust_tools_opts = {
    tools = { -- rust-tools options
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,

        -- how to execute terminal commands
        -- options right now: termopen / quickfix
        executor = require('rust-tools/executors').termopen,

        runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true,

            -- rest of the opts are forwarded to telescope
        },

        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true,

            -- rest of the opts are forwarded to telescope
        },

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {

            -- Only show inlay hints for the current line
            only_current_line = true,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            -- old value: CursorHold
            only_current_line_autocmd = 'CursorMoved',

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,

            -- prefix for parameter hints
            parameter_hints_prefix = '<- ',

            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = '=> ',

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = 'Comment',
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
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

            -- whether the hover action window gets automatically focused
            auto_focus = false,
        },

        -- settings for showing the crate graph based on graphviz and the dot
        -- command
        crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            -- default: x11
            backend = 'x11',
            -- where to store the output, nil for no output stored (relative
            -- path from pwd)
            -- default: nil
            output = nil,
            -- true for all crates.io and external crates, false only the local
            -- crates
            -- default: true
            full = true,
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    -- rust-analyer options
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

require('rust-tools').setup(rust_tools_opts)

return M
