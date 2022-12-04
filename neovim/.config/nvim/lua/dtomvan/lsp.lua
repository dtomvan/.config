local mason_lspconfig = require 'mason-lspconfig'
local lsp_status = require 'lsp-status'
local on_attach = require 'dtomvan.lsp.attach'

local M = {}

-- require('nvim-semantic-tokens').setup {
--     preset = 'default',
--     highlighters = { require 'nvim-semantic-tokens.table-highlighter' },
-- }
--
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
    cmp_nvim_lsp = {}
    cmp_nvim_lsp.default_capabilities = function(input)
        return input
    end
end

local capabilities = vim.tbl_extend(
    'keep',
    cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    lsp_status.capabilities
)

local function get_lua_runtime()
    local result = {}
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. '/lua/'
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end

    -- result[vim.fn.expand '$VIMRUNTIME/lua'] = true

    return result
end

local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local snip_env = require('luasnip').session.config.snip_env
local lua_globals = {
    'vim',
    'describe',
    'it',
    'before_each',
    'after_each',
    'teardown',
    'pending',
    'clear',
    'Color',
    'c',
    'Group',
    'g',
    's',
    'use',
    'xplr',
    'package',
}
for k, _ in pairs(snip_env) do
    table.insert(lua_globals, k)
end

require('lspconfig').sumneko_lua.setup {
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = 'space',
                    indent_size = '4',
                },
            },
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            completion = {
                keywordSnippet = 'Disable',
                showWord = 'Disable',
            },
            diagnostics = {
                enable = true,
                disable = {
                    'trailing-space',
                },
                globals = lua_globals,
            },
            workspace = {
                library = get_lua_runtime(),
                maxPreload = 10000,
                preloadFileSize = 10000,
            },
        },
    },
    filetypes = { 'lua' },
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = require('lspconfig.util').find_git_ancestor,
}

for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
    if not (server == 'rome' or server == 'rust_tools' or server == 'sumneko_lua') then
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
            only_current_line = false,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = 'CursorHold',

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
            on_attach(...)
            vim.keymap.set('n', 'K', '<cmd>RustHoverActions<cr>', { buffer = true, desc = 'Rust hover actions' })
        end,
        standalone = true,
        capabilities = capabilities,
        settings = {
            ['rust-analyzer'] = {
                diagnostics = { disabled = { 'inactive-code' } },
            },
        },
    },
}

require('rust-tools').setup(rust_tools_opts)

return M
