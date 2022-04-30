local lsp_installer_servers = require 'nvim-lsp-installer.servers'

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

-- These two are optional and provide syntax highlighting
-- for Neorg tables and the @document.meta tag
parser_configs.norg_meta = {
    install_info = {
        url = 'https://github.com/nvim-neorg/tree-sitter-norg-meta',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}

parser_configs.norg_table = {
    install_info = {
        url = 'https://github.com/nvim-neorg/tree-sitter-norg-table',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        -- If you want an easy overview, select all of them and
        -- type :!column -t -s' '<cr>
        'bash',
        'c',
        'cmake',
        'comment',
        'cpp',
        'c_sharp',
        'css',
        'dart',
        'dockerfile',
        'fennel',
        'fish',
        'gdscript',
        'go',
        'gomod',
        'graphql',
        'haskell',
        'help',
        'hjson',
        'hocon',
        'html',
        'java',
        'javascript',
        'jsdoc',
        'json',
        'kotlin',
        'latex',
        'lua',
        'make',
        'markdown',
        'python',
        'rasi',
        'regex',
        'rust',
        'scss',
        'svelte',
        'toml',
        'tsx',
        'typescript',
        'vue',
        'yaml',
    },
    sync_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = { 'vim' },
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

local cmp = require 'cmp'

cmp.setup {
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<c-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },

        ['<c-space>'] = cmp.mapping.complete(),

        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },

    -- Youtube:
    --    the order of your sources matter (by default). That gives them priority
    --    you can configure:
    --        keyword_length
    --        priority
    --        max_item_count
    --        (more?)
    sources = {
        -- { name = "gh_issues" },

        -- Youtube: Could enable this only for lua, but nvim_lua handles that already.
        { name = 'neorg' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'zsh' },
        { name = 'path' },
        { name = 'buffer', keyword_length = 5 },
    },

    -- Youtube: mention that you need a separate snippets plugin
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    -- formatting = {
    --     -- Youtube: How to set up nice formatting for your sources.
    --     format = lspkind.cmp_format {
    --         with_text = true,
    --         menu = {
    --             buffer = '[buf]',
    --             nvim_lsp = '[LSP]',
    --             nvim_lua = '[api]',
    --             path = '[path]',
    --             luasnip = '[snip]',
    --             -- gh_issues = "[issues]",
    --         },
    --     },
    -- },

    experimental = {
        -- I like the new menu better! Nice work hrsh7th
        native_menu = false,

        -- Let's play with this for a day or two
        ghost_text = true,
    },
}

local lsp_status = require 'lsp-status'
local lsp_installer = require 'nvim-lsp-installer'

-- Mappings.
local on_attach = function(client, bufnr)
    lsp_status.on_attach(client)

    local function buf_set_keymap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, noremap = true })
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', vim.lsp.buf.declaration)
    buf_set_keymap('n', 'gd', vim.lsp.buf.definition)
    buf_set_keymap('n', 'K', vim.lsp.buf.hover)
    buf_set_keymap('n', 'gi', vim.lsp.buf.implementation)
    buf_set_keymap('n', '<C-k>', vim.lsp.buf.signature_help)
    buf_set_keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
    buf_set_keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
    buf_set_keymap('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
    buf_set_keymap('n', '<space>D', vim.lsp.buf.type_definition)
    buf_set_keymap('n', '<space>rn', require('utils').quick_fix_rename)
    buf_set_keymap('n', '<space>a', vim.lsp.buf.code_action)
    buf_set_keymap('n', 'gr', vim.lsp.buf.references)
    buf_set_keymap('n', '<space>e', vim.diagnostic.open_float)
    buf_set_keymap('n', '[d', vim.diagnostic.goto_prev)
    buf_set_keymap('n', ']d', vim.diagnostic.goto_next)
    buf_set_keymap('n', '<C-f>', vim.lsp.buf.formatting)

    -- Trouble.nvim
    buf_set_keymap('n', '<leader>xx', '<cmd>Trouble<cr>')
    buf_set_keymap('n', '<leader>xc', '<cmd>TroubleClose<cr>')
    buf_set_keymap('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')
    buf_set_keymap('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>')
    buf_set_keymap('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
    buf_set_keymap('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
    buf_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<cr>')
end

lsp_status.register_progress()

local capabilities = vim.tbl_extend(
    'keep',
    require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    lsp_status.capabilities
)
-- Rust
local rust_command = function()
    local _, server = lsp_installer_servers.get_server 'rust_analyzer'
    return server._default_options.cmd
end
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
        cmd = rust_command(),
        capabilities = capabilities,
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

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    -- (optional) Customize the options passed to the server
    if server.name == 'sumneko_lua' then
        require('lspconfig').sumneko_lua.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
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
    elseif server.name == 'rome' then
        opts.filetypes = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescript.tsx',
            'typescriptreact',
        }
        server:setup(opts)
    elseif server.name == 'rust_analyzer' then
        -- Do nothing, you should call rust_tools beforehand
        -- We are using it's auto-installed path, though.
    else
        -- This setup() function is exactly the same as lspconfig's setup function.
        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        server:setup(opts)
    end
end)

require('rust-tools').setup(rust_tools_opts)
