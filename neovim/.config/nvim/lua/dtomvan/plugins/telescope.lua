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
        end
    },
    'nvim-telescope/telescope-symbols.nvim',
    {
        'nvim-telescope/telescope-fzy-native.nvim',
        lazy = true,
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        lazy = true,
        keys = {
            {
                '<leader>pv',
                function()
                    require('telescope').extensions.file_browser.file_browser()
                end,
            },
        },
    },
}
