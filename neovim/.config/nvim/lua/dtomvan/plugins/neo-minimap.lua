local M = {
    'ziontee113/neo-minimap',
    event = { 'BufReadPost', 'BufNewFile' },
}

M.config = function()
    local nm = require 'neo-minimap'

    nm.set({ 'zi', 'zo' }, '*.rs', {
        events = { 'BufEnter' },
        query = {
            [[
        ;; query
(enum_item (type_identifier) @cap)
(trait_item (type_identifier) @cap)
(struct_item (type_identifier) @cap)
((impl_item) @cap)
(function_item (identifier) @cap)
(mod_item (identifier) @cap)
(macro_definition (identifier) @cap)
        ]],
            1,
        },
        regex = {},
        search_patterns = {
            { 'impl', '<C-j>', true },
            { 'impl', '<C-k>', false },
            { 'mod',  '<C-l>', false },
        },
        height_toggle = { 20, 25 },
    })

    nm.set({ 'zo', 'zu' }, '*.tex', {
        events = { 'BufEnter' },
        query = {
            [[
            ;; query
            ((section text: (curly_group (text) @cap)))
            ((subsection text: (curly_group (text) @cap)))
            ((subsubsection text: (curly_group (text) @cap)))
            ]],
            [[
            ;; query
            ((generic_environment begin: (begin name: (curly_group_text text: (text) @cap))))
            ]],
        },
    })

    nm.set({ 'zi', 'zo', 'zu' }, '*.lua', {
        events = { 'BufEnter' },
        query = {
            [[
    ;; query
    ((function_declaration) @cap)
    ((assignment_statement(expression_list((function_definition) @cap))))
    ]],
            1,
            [[
    ;; query
    ((function_declaration) @cap)
    ((assignment_statement(expression_list((function_definition) @cap))))
    ((field (identifier) @cap) (#eq? @cap "keymaps"))
    ]],
            [[
    ;; query
    ((for_statement) @cap)
    ((function_declaration) @cap)
    ((assignment_statement(expression_list((function_definition) @cap))))
    ((function_call (identifier)) @cap (#vim-match? @cap "^__*" ))
    ((function_call (dot_index_expression) @field (#eq? @field "vim.keymap.set")) @cap)
    ]],
            [[
    ;; query
    ((for_statement) @cap)
    ((function_declaration) @cap)
    ((assignment_statement(expression_list((function_definition) @cap))))
    ]],
        },
        regex = {
            {},
            { [[^\s*---*\s\+\w\+]], [[--\s*=]] },
            { [[^\s*---*\s\+\w\+]], [[--\s*=]] },
            {},
        },
        search_patterns = {
            { 'function', '<C-j>', true },
            { 'function', '<C-k>', false },
            { 'keymap',   '<A-j>', true },
            { 'keymap',   '<A-k>', false },
        },
        win_opts = { scrolloff = 1 },
        disable_indentaion = true,
    })
end

return M
