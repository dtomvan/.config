local t = function(k, e)
    return ('<cmd>Telescope %s %s<cr>'):format(k, e or '')
end

local ivy = require('dtomvan.utils.func').set_nth(t, 'theme=ivy', 2)

return {
    {
        'nvim-telescope/telescope.nvim',
        keys = {
            '<leader>B',
            '<leader>dd',
            '<leader>fb',
            '<leader>fp',
            '<leader>q',
            '<leader>T',
            { '<leader>u',   t 'undo' },
            { '<c-p>',       t 'live_grep' },
            { '<leader>:',   t 'command_history' },
            { '<m-x>',       ivy 'commands' },
            { '<leader>ft',  t 'lsp_workspace_symbols' },
            { '<C-e>',       t 'fd' },
            { '<leader>h',   ivy 'help_tags' },
            { '<leader>?',   t 'oldfiles' },
            { '<leader>/',   ivy 'current_buffer_fuzzy_find' },
            { '<leader>;',   t 'resume' },
            { '<leader>fds', ivy 'lsp_document_symbols' },
        },
        cmd = 'Telescope',
        opts = function(_, opts)
            local tr
            local function trouble(...)
                if not tr then
                    tr = require('trouble.providers.telescope').open_with_trouble
                end
                return tr(...)
            end
            return vim.tbl_deep_extend("force", opts, {
                defaults = {
                    winblend = 10,
                    mappings = {
                        i = { ['<c-s-t>'] = trouble },
                        n = { ['<c-s-t>'] = trouble },
                    },
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--multiline',
                        '--vimgrep',
                        '--pcre2',
                        '--smart-case',
                    },
                },
                extensions = {
                    undo = {},
                    fzy_native = {
                        override_generic_sorter = true,
                        override_file_sorter = true,
                    },
                },
            })
        end,
        config = function(_, opts)
            require 'telescope'.setup(opts)
            CONF.telescope()
        end,
    },
    'debugloop/telescope-undo.nvim',
    'nvim-telescope/telescope-symbols.nvim',
    {
        'nvim-telescope/telescope-fzy-native.nvim',
        lazy = true,
    },
    -- Use Telescope as vim.ui.select
    -- and a fancy prompt for vim.ui.input
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.input(...)
            end
        end,
    },

}
