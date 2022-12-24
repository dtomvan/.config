-- Keep this for later, too early in development
return {
    'folke/noice.nvim',
    event = 'VimEnter',
    config = function()
        require 'dtomvan.config.noice'
    end,
    dependencies = 'nvim-lua/lsp-status.nvim',
}
