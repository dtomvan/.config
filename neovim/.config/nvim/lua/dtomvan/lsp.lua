local lsp_installer_servers = require 'nvim-lsp-installer.servers'

local lsp_signature = require 'lsp_signature'
local lsp_status = require 'lsp-status'
local lsp_installer = require 'nvim-lsp-installer'
lsp_installer.setup {}
lsp_signature.setup { floating_window = false }

-- Mappings.
local on_attach = function(client, bufnr)
    lsp_signature.on_attach()
    lsp_status.on_attach(client)

    local function buf_map(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, noremap = true })
    end

    local function buf_opt(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_map('n', 'gD', vim.lsp.buf.declaration)
    buf_map('n', 'gd', vim.lsp.buf.definition)
    buf_map('n', 'K', vim.lsp.buf.hover)
    buf_map('n', 'gi', vim.lsp.buf.implementation)
    buf_map('n', '<C-k>', vim.lsp.buf.signature_help)
    buf_map('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
    buf_map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
    buf_map('n', '<space>wl', function()
        vim.pretty_print(vim.lsp.buf.list_workspace_folders())
    end)
    buf_map('n', '<space>D', vim.lsp.buf.type_definition)
    buf_map('n', '<space>rn', require('dtomvan.utils').quick_fix_rename)
    buf_map('n', '<space>a', vim.lsp.buf.code_action)
    buf_map('n', 'gr', vim.lsp.buf.references)
    buf_map('n', '<space>e', vim.diagnostic.open_float)
    buf_map('n', '[d', vim.diagnostic.goto_prev)
    buf_map('n', ']d', vim.diagnostic.goto_next)
    buf_map('n', '<C-f>', function()
        vim.lsp.buf.format { async = true }
    end)

    -- Trouble.nvim
    buf_map('n', '<leader>xx', '<cmd>Trouble<cr>')
    buf_map('n', '<leader>xc', '<cmd>TroubleClose<cr>')
    buf_map('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')
    buf_map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>')
    buf_map('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
    buf_map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
    buf_map('n', 'gR', '<cmd>Trouble lsp_references<cr>')
end

lsp_status.register_progress()

local capabilities = vim.tbl_extend(
    'keep',
    require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    lsp_status.capabilities
)

-- Rust
local rust_tools_opts = {
    tools = { -- rust-tools options
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,

        -- Whether to show hover actions inside the hover window
        -- This overrides the default hover handler
        hover_with_actions = true,

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
        on_attach = on_attach,
        standalone = true,
        capabilities = capabilities,
        settings = {
            ['rust-analyzer'] = {
                diagnostics = { disabled = { 'inactive-code' } },
            },
        },
    },
}

local function get_lua_runtime()
    local result = {}
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. '/lua/'
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end

    -- This loads the `lua` files from nvim into the runtime.
    result[vim.fn.expand '$VIMRUNTIME/lua'] = true

    -- TODO: Figure out how to get these to work...
    --  Maybe we need to ship these instead of putting them in `src`?...
    result[vim.fn.expand '~/build/neovim/src/nvim/lua'] = true

    return result
end

local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
    settings = {
        Lua = {
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
                globals = {
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
                },
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

for _, server in ipairs(lsp_installer_servers.get_installed_server_names()) do
    if not (server == 'rome' or server == 'rust_analyzer' or server == 'sumneko_lua') then
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

require('rust-tools').setup(rust_tools_opts)
