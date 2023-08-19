return {
    {
        'nvim-telescope/telescope.nvim',
        keys = {
            '<c-p>',
            '<leader>B',
            '<leader>dd',
            '<leader>fb',
            '<leader>fp',
            '<leader>q',
            '<leader>:',
            '<m-x>',
            '<leader>ft',
            '<C-e>',
            '<leader>h',
            '<leader>h',
            '<leader>?',
            '<leader>/',
            '<leader>;',
            '<leader>T',
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
                    winblend = require('catppuccin').options.transparent_background and 0
                        or 10,
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
