require('packer').startup(function()
    -- Packer
    use 'wbthomason/packer.nvim'
    -- Tpope goodness
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-git'
    use 'tpope/vim-fugitive'
    -- Discord presence
    use 'andweeb/presence.nvim'
    -- Gruvbox (https://www.youtube.com/watch?v=DsyptvUvu3A)
    use 'morhetz/gruvbox'
    use 'rebelot/kanagawa.nvim'
    use {
        'feline-nvim/feline.nvim',
        config = function()
            vim.o.background = 'dark'
            vim.g.gruvbox_contrast_dark = 'hard'
            vim.g.gruvbox_invert_selection = 0
            vim.cmd 'colorscheme kanagawa'

            require('feline').setup {
                preset = 'noicon',
            }
        end,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    -- Prime goodness
    use 'ThePrimeagen/harpoon'
    use 'ThePrimeagen/refactoring.nvim'
    -- Git signs
    use 'lewis6991/gitsigns.nvim'
    -- TJ telescope Johnson
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    -- Rust or Bust
    use 'rust-lang/rust.vim'
    use 'cespare/vim-toml'
    use 'tjdevries/nlua.nvim'
    use 'simrat39/rust-tools.nvim'
    -- Lsp
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'glepnir/lspsaga.nvim'
    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
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
    use 'ron-rs/ron.vim'
    use 'Raimondi/vim-transpose-words'
    use {
        'glacambre/firenvim',
        run = function()
            vim.fn['firenvim#install'](0)
        end,
    }
    -- Misc
    use 'tversteeg/registers.nvim'
    use 'junegunn/vim-easy-align'
    use 'andymass/vim-matchup'
    use 'stefandtw/quickfix-reflector.vim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'williamboman/nvim-lsp-installer',
        run = function()
            vim.cmd [[LspInstall rust_analyzer taplo pylsp kotlin_language_server]]
        end,
    }
    use 'ggandor/lightspeed.nvim'
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('null-ls').setup {
                sources = {
                    require('null-ls').builtins.formatting.stylua,
                    require('null-ls').builtins.formatting.taplo,
                },
            }
        end,
        requires = { 'nvim-lua/plenary.nvim' },
    }
end)
