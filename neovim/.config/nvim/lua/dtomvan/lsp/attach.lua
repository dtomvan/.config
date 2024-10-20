local utils = require 'dtomvan.utils'

return function(client, bufnr)
    local ok_stat, lsp_status = pcall(require, 'lsp-status')
    if ok_stat then
        lsp_status.on_attach(client)
    end

    --- Slow?
    if client.name ~= 'coach' then
        client.server_capabilities.semanticTokensProvider = nil
    end
    local caps = client.server_capabilities

    if caps.documentSymbolProvider then
        local ok, navic = pcall(require, 'nvim-navic')
        if ok then
            navic.attach(client, bufnr)
            require('nvim-navbuddy').attach(client, bufnr)
        end
    end

    local function buf_map(mode, lhs, rhs, desc)
        vim.keymap.set(
            mode,
            lhs,
            rhs,
            { buffer = bufnr, noremap = true, desc = desc }
        )
    end

    -- Enable completion triggered by <c-x><c-o>
    local function buf_opt(k, v)
        return utils.buf_set(bufnr, k, v)
    end
    buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')
    buf_opt('tagfunc', 'v:lua.vim.lsp.tagfunc')

    buf_map('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
    buf_map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
    -- buf_map('n', 'K', vim.lsp.buf.hover, 'Open docs ("Hover" functionality)')
    buf_map('n', 'gi', vim.lsp.buf.implementation, 'Goto implementation')
    buf_map(
        'n',
        '<C-k>',
        vim.lsp.buf.signature_help,
        'Display current function signature'
    )
    buf_map(
        'n',
        '<space>wa',
        vim.lsp.buf.add_workspace_folder,
        'Add folder to workspace'
    )
    buf_map(
        'n',
        '<space>wr',
        vim.lsp.buf.remove_workspace_folder,
        'Remove folder from workspace'
    )
    buf_map('n', '<space>wl', function()
        vim.print(vim.lsp.buf.list_workspace_folders())
    end, 'List workspace folders')
    buf_map(
        'n',
        '<space>D',
        vim.lsp.buf.type_definition,
        'Jump to type definition'
    )
    buf_map(
        'n',
        '<space>rn',
        require('dtomvan.utils').quick_fix_rename,
        'LSP Rename'
    )
    buf_map('n', '<space>a', vim.lsp.buf.code_action, 'Code actions')
    buf_map('n', 'gr', vim.lsp.buf.references, 'Goto references')
    buf_map(
        'n',
        '<c-q>',
        vim.diagnostic.setqflist,
        'Set diagnostics in quickfixlist'
    )
    buf_map(
        'n',
        '<space>e',
        vim.diagnostic.open_float,
        'Open diagnostics in floating window'
    )
    buf_map('n', '[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
    buf_map('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
    buf_map(
        'n',
        '<C-f>',
        require('dtomvan.formatter').format_buf,
        'Format buffer'
    )
    local ok, navbuddy = pcall(require, 'nvim-navbuddy')
    if not ok then return end
    buf_map('n', '<leader>ff', navbuddy.open, 'open navbuddy')
end
