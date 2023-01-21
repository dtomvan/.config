return {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPost',
    dependencies = {
        'jay-babu/mason-null-ls.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-lua/lsp-status.nvim'
    },
    cond = function()
        return not vim.g.started_by_firenvim
    end,
}
