require('nvim-treesitter.configs').setup {
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { 'BufWrite', 'CursorHold' },
    },
    sync_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        -- help highlighting is currently broken
        disable = { 'vim', 'help', 'latex' },
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['ic'] = '@call.inner',
                ['ac'] = '@call.outer',
                ['af'] = '@function.outer',
                ['aP'] = '@parameter.outer',
                ['iP'] = '@parameter.inner',
                ['if'] = '@function.inner',
            },
            selection_modes = {
                ['@function.outer'] = 'V', -- linewise
            },
            include_surrounding_whitespace = true,
        },
    },
    refactor = {
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = 'gd',
                list_definitions = 'gD',
                list_definitions_toc = 'gO',
                goto_next_usage = '<a-*>',
                goto_previous_usage = '<a-#>',
            },
        },
    },
}

require('treesitter-context').setup {
    max_lines = 5,
    trim_scope = 'outer',
    mode = 'topline',
    separator = nil,
}
