require('packer').startup(function() 
    use 'wbthomason/packer.nvim'
    use 'cespare/vim-toml'
    use 'editorconfig/editorconfig-vim'
    use 'junegunn/vim-easy-align'
    use 'tpope/vim-commentary'
    use 'itchyny/lightline.vim'
    use 'sheerun/vim-wombat-scheme'
    use 'preservim/nerdtree'
    use 'tpope/vim-surround'
    use 'vim-scripts/auto-pairs-gentle'
    use 'andymass/vim-matchup'
    use 'easymotion/vim-easymotion'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'neovim/nvim-lspconfig'
    use 'RishabhRD/popfix'
    use 'RishabhRD/nvim-lsputils'
    use 'nvim-lua/completion-nvim'
    -- use 'nvim-treesitter/nvim-treesitter'
    use 'TC72/telescope-tele-tabby.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'andweeb/presence.nvim'
    use 'TimUntersberger/neogit'
    use 'tweekmonster/startuptime.vim'
    use 'tjdevries/colorbuddy.vim'
    use 'tjdevries/gruvbuddy.nvim'
    use {
      'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require'my_statusline' end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'airblade/vim-gitgutter'
    use 'nvim-telescope/telescope-project.nvim'
    use 'ThePrimeagen/vim-be-good'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'tversteeg/registers.nvim'
    use 'rust-lang/rust.vim'
    use 'jreybert/vimagit'
    use 'kana/vim-tabpagecd'
    use 'mhinz/vim-startify'
end)

