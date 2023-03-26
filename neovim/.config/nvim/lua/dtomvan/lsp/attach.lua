return function(client, bufnr)
    require('dtomvan.lsp.right_click').set_lsp_rclick_menu()
    require('lsp-status').on_attach(client)

    -- if vim.tbl_contains({ 'lua', 'rust', 'python' }, vim.bo.ft) then
    --     client.server_capabilities.semanticTokensProvider = nil
    -- end

    --- Slow?
    client.server_capabilities.semanticTokensProvider = nil
    local caps = client.server_capabilities

    if caps.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end

    local function buf_map(mode, lhs, rhs, desc)
        vim.keymap.set(
            mode,
            lhs,
            rhs,
            { buffer = bufnr, noremap = true, desc = desc }
        )
    end

    local function buf_opt(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')
    buf_opt('tagfunc', 'v:lua.vim.lsp.tagfunc')

    buf_map('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
    buf_map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
    buf_map('n', 'K', vim.lsp.buf.hover, 'Open docs ("Hover" functionality)')
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
end
