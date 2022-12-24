return {
    -- Tpope stuff
    'tpope/vim-surround',
    'tpope/vim-git',
    'tpope/vim-fugitive',
    'tpope/vim-eunuch',
    'tpope/vim-unimpaired',
    'tpope/vim-repeat',
    -- use 'tpope/vim-vinegar'
    'tpope/vim-sleuth',
    'tpope/vim-endwise',

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {}
        end,
    },
    {
        'numToStr/Navigator.nvim',
        config = function()
            local Navigator = require 'Navigator'
            Navigator.setup()
            vim.keymap.set('n', '<A-h>', Navigator.left)
            vim.keymap.set('n', '<A-l>', Navigator.right)
            vim.keymap.set('n', '<A-k>', Navigator.up)
            vim.keymap.set('n', '<A-j>', Navigator.down)
            vim.keymap.set('n', '<A-p>', Navigator.previous)
        end,
    },

    -- Startup time improvements
    {
        'lewis6991/impatient.nvim',
        config = function()
            require 'impatient'
        end,
    },

    -- Plenary
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',

    -- Color scheme
    'levouh/tint.nvim',
    require('dtomvan.colors').theme(),

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
    'theprimeagen/jvim.nvim',

    -- Git signs
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {}
        end,
    },

    -- TJ telescope Johnson
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require 'dtomvan.config.telescope'
        end,
    },
    'nvim-telescope/telescope-fzy-native.nvim',

    -- Use Telescope as vim.ui.select
    -- and a fancy prompt for vim.ui.input
    {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup {}
        end,
    },

    -- Rust or Bust
    'ron-rs/ron.vim',
    'simrat39/rust-tools.nvim',

    -- Lsp
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
        },
    },
    'nvim-lua/lsp_extensions.nvim',

    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            vim.cmd.TSUpdate()
        end,
        config = function()
            require 'dtomvan.config.treesitter'
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-refactor',
        },
    },
    'theHamsta/nvim-semantic-tokens',

    'tjdevries/nlua.nvim',
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'jayp0521/mason-null-ls.nvim',
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup {
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
            }
            require('mason-null-ls').setup {
                automatic_setup = true,
            }
        end,
        build = function()
            local servers = {
                'black',
                'stylua',
                'shellcheck',
            }
            require('mason.api.command').MasonInstall(servers)
        end,
    },

    -- Autocompletion
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function()
            R 'dtomvan.config.luasnip'
        end,
    },

    -- Auto pairs
    'Krasjet/auto.pairs',

    -- Kotlin
    'udalov/kotlin-vim',

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
    'andymass/vim-matchup',
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
