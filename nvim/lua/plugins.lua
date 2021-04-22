require('packer').startup(function() 
    use 'wbthomason/packer.nvim'
    use 'cespare/vim-toml'
    use 'editorconfig/editorconfig-vim'
    use 'junegunn/vim-easy-align'
    use 'tpope/vim-commentary'
    use 'sheerun/vim-wombat-scheme'
    use 'tpope/vim-surround'
    use 'andymass/vim-matchup'
    use 'easymotion/vim-easymotion'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'neovim/nvim-lspconfig'
    use 'RishabhRD/popfix'
    use 'RishabhRD/nvim-lsputils'
    use 'nvim-lua/completion-nvim'
    use 'TC72/telescope-tele-tabby.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'andweeb/presence.nvim'
    use 'tweekmonster/startuptime.vim'
    use 'tjdevries/colorbuddy.vim'
    use 'tjdevries/gruvbuddy.nvim'
    use {
      'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() R'my_statusline' end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    use 'ThePrimeagen/vim-be-good'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'tversteeg/registers.nvim'
    use 'rust-lang/rust.vim'
    use 'kana/vim-tabpagecd'
    use 'oberblastmeister/termwrapper.nvim'
    use 'Th3Whit3Wolf/onebuddy'
    use 'Shougo/deoplete.nvim'
    use 'roxma/nvim-yarp'
    use 'roxma/vim-hug-neovim-rpc'
    use 'Shougo/neosnippet.vim'
    use 'Shougo/neosnippet-snippets'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'tjdevries/nlua.nvim'
    use 'https://github.com/skanehira/badapple.vim.git'
    use 'glepnir/dashboard-nvim'
    use 'onsails/lspkind-nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'https://github.com/tweekmonster/startuptime.vim.git'
    use 'tjdevries/train.nvim'
    use 'lervag/wiki.vim'
    use 'liuchengxu/vim-clap'
    use 'windwp/nvim-autopairs'
end)
