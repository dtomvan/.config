return {
    'folke/noice.nvim',
    event = 'VimEnter',
    config = function()
        require 'dtomvan.config.noice'
    end,
    dependencies = 'nvim-lua/lsp-status.nvim',
    cond = vim.g.started_by_firenvim == nil,
}
