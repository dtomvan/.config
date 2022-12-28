return {
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    build = ':TSUpdate',
    config = function()
        require 'dtomvan.config.treesitter'
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-refactor',
    },
}
