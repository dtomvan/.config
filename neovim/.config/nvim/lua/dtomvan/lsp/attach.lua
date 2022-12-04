local lsp_status = require 'lsp-status'
local navic = require 'nvim-navic'
local right_click = require 'dtomvan.lsp.right_click'

return function(client, bufnr)
    right_click.set_lsp_rclick_menu()
    lsp_status.on_attach(client)

    local caps = client.server_capabilities

    if caps.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    -- if
    --     caps.semanticTokensProvider
    --     and caps.semanticTokensProvider.full
    --     and type(vim.lsp.buf.semantic_tokens_full) == 'function'
    -- then
    --     local augroup = vim.api.nvim_create_augroup('SemanticTokens', {})
    --     vim.api.nvim_create_autocmd('TextChanged', {
    --         group = augroup,
    --         buffer = bufnr,
    --         callback = vim.lsp.buf.semantic_tokens_full,
    --     })
    --     -- fire it first time on load as well
    --     vim.lsp.buf.semantic_tokens_full()
    -- end

    local function buf_map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, noremap = true, desc = desc })
    end

    local function buf_opt(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_map('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
    buf_map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
    buf_map('n', 'K', vim.lsp.buf.hover, 'Open docs ("Hover" functionality)')
    buf_map('n', 'gi', vim.lsp.buf.implementation, 'Goto implementation')
    buf_map('n', '<C-k>', vim.lsp.buf.signature_help, 'Display current function signature')
    buf_map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, 'Add folder to workspace')
    buf_map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, 'Remove folder from workspace')
    buf_map('n', '<space>wl', function()
        vim.pretty_print(vim.lsp.buf.list_workspace_folders())
    end, 'List workspace folders')
    buf_map('n', '<space>D', vim.lsp.buf.type_definition, 'Jump to type definition')
    buf_map('n', '<space>rn', require('dtomvan.utils').quick_fix_rename, 'LSP Rename')
    buf_map('n', '<space>a', vim.lsp.buf.code_action, 'Code actions')
    buf_map('n', 'gr', vim.lsp.buf.references, 'Goto references')
    buf_map('n', '<c-q>', vim.diagnostic.setqflist, 'Set diagnostics in quickfixlist')
    buf_map('n', '<space>e', vim.diagnostic.open_float, 'Open diagnostics in floating window')
    buf_map('n', '[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
    buf_map('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
    buf_map('n', '<C-f>', function()
        vim.lsp.buf.format { async = true }
    end, 'Format buffer')

    -- Trouble.nvim
    -- buf_map('n', '<leader>xx', '<cmd>Trouble<cr>')
    -- buf_map('n', '<leader>xc', '<cmd>TroubleClose<cr>')
    -- buf_map('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')
    -- buf_map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>')
    -- buf_map('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
    -- buf_map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
    -- buf_map('n', 'gR', '<cmd>Trouble lsp_references<cr>')
end
