require('packer').startup(function()
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Tpope stuff
    use 'tpope/vim-surround'
    use 'tpope/vim-git'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-repeat'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-endwise'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {}
        end,
    }

    -- Startup time improvements
    use {
        'lewis6991/impatient.nvim',
        config = function()
            require 'impatient'
        end,
    }

    -- Plenary
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    -- Color scheme
    use 'levouh/tint.nvim'
    require('dtomvan.colors').use_themes(use)

    -- After opening a file, return to the last position
    use {
        'ethanholz/nvim-lastplace',
        config = function()
            require('nvim-lastplace').setup()
        end,
    }

    -- Status line
    -- use {
    --     'j-hui/fidget.nvim',
    --     config = function()
    --         require('fidget').setup {}
    --     end,
    --     requires = 'nvim-lua/lsp-status.nvim',
    -- }
    use {
        'tjdevries/express_line.nvim',
        config = function()
            R 'dtomvan.plugins.express_line'
        end,
        requires = { 'kyazdani42/nvim-web-devicons' },
    }
    use {
        'SmiteshP/nvim-navic',
        requires = 'neovim/nvim-lspconfig',
        config = function()
            require 'dtomvan.plugins.gps'
        end,
    }

    -- Prime goodness
    use 'ThePrimeagen/harpoon'
    use 'ThePrimeagen/refactoring.nvim'
    use { 'ThePrimeagen/vim-be-good', cmd = 'VimBeGood' }
    use 'theprimeagen/jvim.nvim'

    -- Git signs
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {}
        end,
    }

    -- TJ telescope Johnson
    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            R 'dtomvan.plugins.telescope'
        end,
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- Use Telescope as vim.ui.select
    -- and a fancy prompt for vim.ui.input
    use {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup {}
        end,
    }

    -- Rust or Bust
    use 'ron-rs/ron.vim'
    use 'simrat39/rust-tools.nvim'

    -- Lsp
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/mason.nvim',
        },
    }
    use 'nvim-lua/lsp_extensions.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            vim.cmd.TSUpdate()
        end,
        config = function()
            R 'dtomvan.plugins.treesitter'
        end,
        requires = {
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-refactor',
        },
    }
    use 'theHamsta/nvim-semantic-tokens'

    use 'tjdevries/nlua.nvim'
    use {
        'williamboman/mason.nvim',
        requires = {
            'williamboman/mason-lspconfig.nvim',
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
        end,
        run = function()
            local servers = {
                'black',
                'stylua',
                'shellcheck',
            }
            require('mason.api.command').MasonInstall(servers)
        end,
    }
    use 'ray-x/lsp_signature.nvim'

    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require 'dtomvan.plugins.null-ls'
        end,
        requires = { 'nvim-lua/plenary.nvim' },
    }

    -- Autocompletion
    use {
        'L3MON4D3/LuaSnip',
        requires = {
            'rafamadriz/friendly-snippets',
        },
        config = function()
            R 'dtomvan.plugins.luasnip'
        end,
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/nvim-cmp',
            'f3fora/cmp-spell',
            'onsails/lspkind-nvim',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            R 'dtomvan.plugins.cmp'
        end,
    }

    -- Auto pairs
    use 'Krasjet/auto.pairs'

    -- Kotlin
    use 'udalov/kotlin-vim'

    -- xplr
    use {
        'fhill2/xplr.nvim',
        run = function()
            require('xplr').install { hide = true }
            R 'dtomvan.plugins.xplr'
        end,
        requires = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
    }

    -- Misc
    use 'rcarriga/nvim-notify'

    -- Keep this for later, too early in development
    use {
        'folke/noice.nvim',
        event = 'VimEnter',
        config = function()
            require 'dtomvan.plugins.noice'
        end,
        requires = 'nvim-lua/lsp-status.nvim',
    }

    use {
        'ghillb/cybu.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
        config = function()
            local cybu = require 'cybu'
            cybu.setup {
                style = {
                    highlights = {
                        current_buffer = 'CybuFocus',
                        adjacent_buffers = 'NormalFloat',
                        background = 'NormalFloat',
                        border = 'WinSeparator',
                    },
                },
            }
            local function c(dir)
                return function()
                    cybu.cycle(dir)
                end
            end

            vim.keymap.set({ 'n', 'v' }, '<s-tab>', c 'prev')
            vim.keymap.set({ 'n', 'v' }, '<tab>', c 'next')
        end,
    }

    -- Misc
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                show_current_context = true,
                show_current_context_start = true,
            }
        end,
    }
    use 'tversteeg/registers.nvim'
    use 'junegunn/vim-easy-align'
    use 'andymass/vim-matchup'
    use {
        'kevinhwang91/nvim-bqf',
        ft = 'qf',
        config = function()
            require('bqf').setup {}
        end,
    }
    use 'ggandor/lightspeed.nvim'
    use 'Raimondi/vim-transpose-words'
    use {
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
    }

    -- I'm finally using a filetree :)
    use {
        'ms-jpq/chadtree',
        branch = 'chad',
        run = 'python3 -m chadtree deps',
        config = function()
            vim.keymap.set({ 'n', 'i', 's', 'x' }, '<f1>', '<cmd>CHADopen<cr>', { desc = 'CHADopen' })
        end,
    }

    use {
        'gbprod/substitute.nvim',
        config = function()
            require 'dtomvan.plugins.substitute'
        end,
    }

    use {
        'gaoDean/autolist.nvim',
        config = function()
            require('autolist').setup {}
        end,
    }

    -- Profiler
    use 'dstein64/vim-startuptime'
    -- Only when using on specific machine,
    -- since I don't want to get prompted on others.
    if vim.fn.hostname() == 'tom-pc' then
        -- Developer profiler
        use 'wakatime/vim-wakatime'
    end

    -- Which key functionality
    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {}
        end,
    }

    use {
        'echasnovski/mini.nvim',
        config = function()
            require 'dtomvan.plugins.mini'
        end,
    }

    -- LaTeX
    use {
        'lervag/vimtex',
        config = function()
            vim.g.tex_conceal = 'abdmg'
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_view_method = 'zathura'
        end,
    }
end)
