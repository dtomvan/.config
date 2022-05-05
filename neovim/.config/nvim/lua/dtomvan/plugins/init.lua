require('packer').startup(function()
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Startup time improvements
    use {
        'lewis6991/impatient.nvim',
        config = function()
            require 'impatient'
        end,
    }
    use 'nathom/filetype.nvim'

    -- Plenary
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    -- Discord presence
    use 'andweeb/presence.nvim'

    -- Tpope goodness
    use 'tpope/vim-surround'
    use 'tpope/vim-git'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-repeat'
    use 'tpope/vim-vinegar'

    -- Commenting
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    }

    use {
        'rebelot/kanagawa.nvim',
        config = function()
            vim.o.background = 'dark'
            vim.cmd 'colorscheme kanagawa'
            vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
        end,
    }
    -- Status line
    use 'nvim-lua/lsp-status.nvim'

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
    use {
        'tjdevries/express_line.nvim',
        config = function()
            R 'dtomvan.plugins.express_line'
        end,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    -- Use Telescope as vim.ui.select
    -- and a fancy prompt for vim.ui.input
    use {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup {}
        end,
    }

    -- Rust or Bust
    use { 'rust-lang/rust.vim', ft = 'rust' }
    use { 'cespare/vim-toml', ft = 'toml' }
    use 'simrat39/rust-tools.nvim'

    -- Lsp
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            vim.cmd [[ TSUpdate ]]
        end,
    }
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'glepnir/lspsaga.nvim'
    use 'tjdevries/nlua.nvim'
    use {
        'williamboman/nvim-lsp-installer',
        run = function()
            vim.cmd [[LspInstall rust_analyzer taplo pylsp kotlin_language_server]]
        end,
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('null-ls').setup {
                sources = {
                    require('null-ls').builtins.formatting.stylua,
                    require('null-ls').builtins.formatting.taplo,
                    require('null-ls').builtins.formatting.black,
                },
            }
        end,
        requires = { 'nvim-lua/plenary.nvim' },
    }

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use {
        'L3MON4D3/LuaSnip',
        config = function()
            R 'dtomvan.plugins.luasnip'
        end,
    }
    use 'rafamadriz/friendly-snippets'

    -- Auto pairs
    use 'rstacruz/vim-closer'
    use 'Krasjet/auto.pairs'

    -- Kotlin
    use 'udalov/kotlin-vim'

    -- xplr
    use {
        'fhill2/xplr.nvim',
        run = function()
            require('xplr').install { hide = true }
        end,
        requires = { { 'nvim-lua/plenary.nvim' }, { 'MunifTanjim/nui.nvim' } },
    }

    -- Misc
    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                stages = 'fade_in_slide_out',
                on_open = nil,
                on_close = nil,

                -- Render function for notifications. See notify-render()
                render = 'default',
                timeout = 5000,
                --[[
                WARN: Do not remove this line, otherwise the plugin will think
                that there is no background color and it'll throw a bunch of
                errors.
                ]]
                background_colour = '#000000',
            }

            -- Default vim notify + the plugin
            vim.notify = function(msg, level)
                require 'notify'(msg, level)
                if level == vim.log.levels.ERROR then
                    vim.api.nvim_err_writeln(msg)
                elseif level == vim.log.levels.WARN then
                    vim.api.nvim_echo({ { msg, 'WarningMsg' } }, true, {})
                else
                    vim.api.nvim_echo({ { msg } }, true, {})
                end
            end
        end,
    }
    use 'tversteeg/registers.nvim'
    use 'junegunn/vim-easy-align'
    use 'andymass/vim-matchup'
    use 'stefandtw/quickfix-reflector.vim'
    use 'ggandor/lightspeed.nvim'
    use { 'ron-rs/ron.vim', ft = 'ron' }
    use 'Raimondi/vim-transpose-words'

    -- Neorg
    use {
        'nvim-neorg/neorg',
        config = function()
            require 'dtomvan.plugins.norg'
        end,
        run = ':TSInstall norg norg_meta norg_table',
        requires = 'nvim-lua/plenary.nvim',
    }

    -- Profiler
    use 'dstein64/vim-startuptime'
    -- Developer profiler
    use 'wakatime/vim-wakatime'
end)
