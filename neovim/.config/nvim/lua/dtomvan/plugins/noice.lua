return {
    'folke/noice.nvim',
    event = 'VimEnter',
    config = CONF.noice,
    dependencies = 'nvim-lua/lsp-status.nvim',
    cond = vim.g.started_by_firenvim == nil,
    dev = true,
}
