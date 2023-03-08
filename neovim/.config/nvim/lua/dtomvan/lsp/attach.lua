-- local st = vim.lsp.semantic_tokens
local lsp_status = require 'lsp-status'
local navic = require 'nvim-navic'
local right_click = require 'dtomvan.lsp.right_click'

return function(client, bufnr)
    right_click.set_lsp_rclick_menu()
    lsp_status.on_attach(client)

    -- if vim.tbl_contains({ 'lua', 'rust', 'python' }, vim.bo.ft) then
    --     client.server_capabilities.semanticTokensProvider = nil
    -- end

    --- Slow?
    client.server_capabilities.semanticTokensProvider = nil
    local caps = client.server_capabilities
    -- if caps.semanticTokensProvider then
    --     vim.api.nvim_create_autocmd('LspTokenUpdate', {
    --         buffer = 0,
    --         callback = function(cb)
    --             local tk = cb.data.token
    --             if tk.type ~= 'variable' or tk.modifiers.readonly then
    --                 return
    --             end
    --
    --             local text = vim.api.nvim_buf_get_text(cb.buf, tk.line, tk.start_col, tk.line, tk.end_col, {})[1]
    --             if text ~= string.upper(text) --[[ and not (vim.bo.ft == 'lua' and tk.modifiers.global) ]] then
    --                 return
    --             end
    --
    --             st.highlight_token(tk, cb.buf, cb.data.client_id, 'Error')
    --         end,
    --     })
    -- end

    if caps.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    local function buf_map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, noremap = true, desc = desc })
    end

    local function buf_opt(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')
    buf_opt('tagfunc', 'v:lua.vim.lsp.tagfunc')

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
end
