return {
    -- Plenary
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',

    {
        'numToStr/Comment.nvim',
        config = {},
    },
    {
        'numToStr/Navigator.nvim',
        config = function()
            local Navigator = require 'Navigator'
            Navigator.setup {}
            vim.keymap.set('n', '<A-h>', Navigator.left)
            vim.keymap.set('n', '<A-l>', Navigator.right)
            vim.keymap.set('n', '<A-k>', Navigator.up)
            vim.keymap.set('n', '<A-j>', Navigator.down)
            vim.keymap.set('n', '<A-p>', Navigator.previous)
        end,
    },

    -- After opening a file, return to the last position
    {
        'ethanholz/nvim-lastplace',
        config = function()
            require('nvim-lastplace').setup()
        end,
    },

    -- Prime goodness
    'ThePrimeagen/harpoon',
    'ThePrimeagen/refactoring.nvim',
    { 'ThePrimeagen/vim-be-good', cmd = 'VimBeGood' },
    {
        'theprimeagen/jvim.nvim',
        ft = 'json',
    },

    -- Git signs
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufEnter',
        config = function()
            require('gitsigns').setup {}
        end,
    },

    -- Use Telescope as vim.ui.select
    -- and a fancy prompt for vim.ui.input
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        config = {},
    },

    -- Rust or Bust
    { 'ron-rs/ron.vim', ft = 'ron' },
    'simrat39/rust-tools.nvim',

    -- Lsp
    {
        'williamboman/mason.nvim',
        lazy = true,
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/lsp_extensions.nvim',
        },
        config = {},
        build = function()
            local servers = {
                'black',
                'stylua',
                'shellcheck',
            }
            require('mason.api.command').MasonInstall(servers)
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        config = {
            ensure_installed = {
                'clangd',
                'emmet_ls',
                'gopls',
                'html',
                'jsonls',
                'kotlin_language_server',
                'lemminx',
                'pylsp',
                'rnix',
                'rust_analyzer',
                'sumneko_lua',
                'svelte',
                -- 'taplo',
                'tsserver',
                'volar',
            },
        },
    },
    {
        'jayp0521/mason-null-ls.nvim',
        lazy = true,
        config = {
            automatic_setup = true,
        },
    },
    {
        'theHamsta/nvim-semantic-tokens',
        disable = true,
        config = function()
            require('nvim-semantic-tokens').setup {
                preset = 'default',
                highlighters = { require 'nvim-semantic-tokens.table-highlighter' },
            }
        end,
    },

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function()
            require 'dtomvan.config.luasnip'
        end,
    },

    -- Kotlin
    { 'udalov/kotlin-vim', ft = 'kotlin' },

    -- Misc
    'rcarriga/nvim-notify',
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                show_current_context = true,
                show_current_context_start = true,
            }
        end,
    },
    'tversteeg/registers.nvim',
    'junegunn/vim-easy-align',
    {
        'andymass/vim-matchup',
        event = 'InsertEnter',
    },
    {
        'kevinhwang91/nvim-bqf',
        ft = 'qf',
        config = function()
            require('bqf').setup {}
        end,
    },
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end,
    },
    'Raimondi/vim-transpose-words',
    {
        'numToStr/FTerm.nvim',
        config = function()
            require('FTerm').setup {
                border = 'rounded',
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
                blend = 20,
            }

            vim.keymap.set({ 'n', 't' }, '<A-i>', require('FTerm').toggle, { desc = 'Toggle terminal' })
        end,
    },

    {
        'prichrd/netrw.nvim',
        config = function()
            require('netrw').setup {}
        end,
    },

    {
        'j-morano/buffer_manager.nvim',
        config = function()
            vim.g.buffer_manager_log_level = 'fatal'
            vim.keymap.set('n', '<c-b>', require('buffer_manager.ui').toggle_quick_menu)
        end,
    },

    {
        'gaoDean/autolist.nvim',
        config = function()
            require('autolist').setup {}
        end,
    },

    -- Profiler
    'dstein64/vim-startuptime',
    -- Only when using on specific machine,
    -- since I don't want to get prompted on others.
    {
        'wakatime/vim-wakatime',
        enabled = function()
            return vim.fn.hostname() == 'tom-pc'
        end,
    },

    {
        'echasnovski/mini.nvim',
        config = function()
            require 'dtomvan.config.mini'
        end,
    },

    -- LaTeX
    {
        'lervag/vimtex',
        cond = function()
            return not vim.g._no_vimtex
        end,
        ft = 'tex',
        config = function()
            vim.g.tex_conceal = 'abdmg'
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_view_method = 'zathura'
        end,
    },
}
