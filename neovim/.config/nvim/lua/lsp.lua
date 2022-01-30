local lsp_installer_servers = require 'nvim-lsp-installer.servers'

vim.o.runtimepath = vim.o.runtimepath
    .. ','
    .. os.getenv 'HOME'
    .. '/.local/share/nvim/site/pack/packer/start/friendly-snippets/'
require('luasnip/loaders/from_vscode').load()

require('nvim-treesitter.configs').setup {
    ensure_installed = 'maintained',
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

-- THANKS TJ
local lspkind = require 'lspkind'
lspkind.init()

vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]]

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
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'zsh' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer', keyword_length = 5 },
    },

    -- Youtube: mention that you need a separate snippets plugin
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    formatting = {
        -- Youtube: How to set up nice formatting for your sources.
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[api]',
                path = '[path]',
                luasnip = '[snip]',
                -- gh_issues = "[issues]",
            },
        },
    },

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

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<C-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- Trouble.nvim
    buf_set_keymap('n', '<leader>xx', '<cmd>Trouble<cr>', opts)
    buf_set_keymap('n', '<leader>xc', '<cmd>TroubleClose<cr>', opts)
    buf_set_keymap('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', opts)
    buf_set_keymap('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', opts)
    buf_set_keymap('n', '<leader>xl', '<cmd>Trouble loclist<cr>', opts)
    buf_set_keymap('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', opts)
    buf_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<cr>', opts)
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

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    -- (optional) Customize the options passed to the server
    if server.name == 'sumneko_lua' then
        require('nlua.lsp.nvim').setup(require 'lspconfig', {
            cmd = server._default_options.cmd,
            on_attach = on_attach,

            globals = {
                'Color',
                'c',
                'Group',
                'g',
                's',
                'use',
                'xplr',
                'vim',
            },
        })
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
