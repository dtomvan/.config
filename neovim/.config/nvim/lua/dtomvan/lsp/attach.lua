local lsp_signature = require 'lsp_signature'
local lsp_status = require 'lsp-status'

return function(client, bufnr)
    lsp_signature.on_attach()
    lsp_status.on_attach(client)

    local caps = client.server_capabilities
    if
        caps.semanticTokensProvider
        and caps.semanticTokensProvider.full
        and type(vim.lsp.buf.semantic_tokens_full) == 'function'
    then
        vim.cmd [[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.buf.semantic_tokens_full()]]
        vim.notify 'Support for semantic tokens enabled'
    end

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
    buf_map('n', '<c-q>', vim.diagnostic.setqflist)
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
