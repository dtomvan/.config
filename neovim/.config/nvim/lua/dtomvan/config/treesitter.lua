local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

-- for _, name in ipairs(vim.api.nvim_get_runtime_file('parsers/*', true)) do
--     if vim.fn.isdirectory(name) then
--         local ft = vim.fs.basename(name)
--         if not ft then goto continue end
--         parser_config[ft] = {
--             filetype = ft,
--             maintainers = {
--                 'Tom van Dijk <18gatenmaker6 at gmail dot com>'
--             },
--             install_info = {
--                 url = name,
--                 files = { 'src/parser.c' },
--                 generate_requires_npm = false,
--                 requires_generate_from_grammar = true,
--             },
--         }
--     end
--     ::continue::
-- end

require('tree-sitter-just').setup({})

-- FIXME:
---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'kotlin',
        'lua',
        'markdown',
        'markdown_inline',
        'regex',
        'rust',
        'vimdoc',
    },
    matchup = {
        enable = true,
    },
    indent = {
        enable = true,
    },
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
        disable = function(lang, bufnr)
            for _, i in ipairs { 'latex' } do
                if i == lang then
                    return true
                end
            end
            return vim.api.nvim_buf_line_count(bufnr) > 10000
        end,
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['ac'] = '@call.outer',
                ['af'] = '@function.outer',
                ['aP'] = '@parameter.outer',
                ['iP'] = '@parameter.inner',
                ['if'] = '@function.inner',
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
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
    endwise = {
        enable = true,
    },
}

require('ts_context_commentstring').setup {}

require('treesitter-context').setup {
    max_lines = 5,
    trim_scope = 'outer',
    mode = 'topline',
    separator = nil,
}

require 'nvim-treesitter-sort'.init()

-- local setft = require('nvim-treesitter.parsers').filetype_to_parsername
--
-- for ft, parser in pairs {
-- } do
--     setft[ft] = parser
-- end
