require('packer').startup(function() 
    use 'wbthomason/packer.nvim'
    use 'cespare/vim-toml'
    use 'junegunn/vim-easy-align'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'andymass/vim-matchup'
    use 'easymotion/vim-easymotion'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'andweeb/presence.nvim'
    use 'tweekmonster/startuptime.vim'
    use 'tjdevries/colorbuddy.vim'
    use {
      'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() R'my_statusline' end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    use 'tversteeg/registers.nvim'
    use 'rust-lang/rust.vim'
    use 'kana/vim-tabpagecd'
    use 'Th3Whit3Wolf/onebuddy'
    use 'tjdevries/nlua.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'rstacruz/vim-closer'
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'hrsh7th/nvim-compe'
    use 'simrat39/rust-tools.nvim'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'glepnir/lspsaga.nvim'
    use 'ThePrimeagen/refactoring.nvim'
    -- use 'gelguy/wilder.nvim'
    use 'romgrk/fzy-lua-native'
    use 'nixprime/cpsm'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use {
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabkey = '<Tab>',
                backwards_tabkey = '<S-Tab>',
                act_as_tab = true,
                act_as_shift_tab = false,
                enable_backwards = false,
                completion = true,
                tabouts = {
                    {open = "'", close = "'"},
                    {open = '"', close = '"'},
                    {open = '`', close = '`'},
                    {open = '(', close = ')'},
                    {open = '[', close = ']'},
                    {open = '{', close = '}'}
                },
                ignore_beginning = true,
                exclude = {}
            }
        end,
        requires = {'nvim-treesitter'},
        after = {'nvim-compe'},
        opt = false
    }
end)
