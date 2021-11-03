require('packer').startup(function() 
    use 'wbthomason/packer.nvim'
    use 'cespare/vim-toml'
    use 'junegunn/vim-easy-align'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'andymass/vim-matchup'
    use 'andweeb/presence.nvim'
    use 'stefandtw/quickfix-reflector.vim'
    use 'tweekmonster/startuptime.vim'
    use 'EdenEast/nightfox.nvim'
    -- use {
    --     'hoob3rt/lualine.nvim',
    --     config = function() 
    --         R('nightfox').load()
    --         R('lualine').setup {
    --             options = {
    --                 theme = "nightfox"
    --             }
    --         }
    --     end,
    --     requires = {'kyazdani42/nvim-web-devicons', opt = true}
    -- }
    use {
        'famiu/feline.nvim',
        config = function () 
            R('nightfox').load()
            require('feline').setup({
                preset = 'noicon'
            })
        end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    use 'tversteeg/registers.nvim'
    use 'rust-lang/rust.vim'
    use 'kana/vim-tabpagecd'
    use 'tjdevries/nlua.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'glepnir/lspsaga.nvim'
    use 'ThePrimeagen/refactoring.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use "rafamadriz/friendly-snippets"
    use 'rstacruz/vim-closer'
    use 'Krasjet/auto.pairs'
    -- use 'windwp/nvim-autopairs'
    -- use 'vimwiki/vimwiki'
    -- use { 'ms-jpq/coq_nvim', branch = 'coq'} -- main one
    -- use { 'ms-jpq/coq.artifacts', branch= 'artifacts'} -- 9000+ Snippets
    use 'nvim-lua/popup.nvim'
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use 'vim-scripts/mom.vim'
    use {
        'fhill2/xplr.nvim',
        run = function() require'xplr'.install({hide=true}) end,
        requires = {{'nvim-lua/plenary.nvim'}, {'MunifTanjim/nui.nvim'}}
    }
    use 'tpope/vim-git'
    use 'tpope/vim-fugitive'
    use 'ron-rs/ron.vim'
    use 'Raimondi/vim-transpose-words'
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end 
    }
    use 'ThePrimeagen/harpoon'
end)
