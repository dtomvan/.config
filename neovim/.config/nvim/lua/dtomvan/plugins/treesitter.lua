require('nvim-treesitter.configs').setup {
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
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
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['ic'] = '@call.inner',
                ['ac'] = '@call.outer',
                ['af'] = '@function.outer',
                ['aP'] = '@parameter.outer',
                ['iP'] = '@parameter.inner',
                ['if'] = '@function.inner',
            },
            -- You can choose the select mode (default is charwise 'v')
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
    mode = 'topline', -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
}
