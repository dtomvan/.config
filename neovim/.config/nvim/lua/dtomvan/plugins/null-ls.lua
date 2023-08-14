local utils = require 'dtomvan.utils'

return {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPost',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/lsp-status.nvim',
    },
    config = function()
        utils.source_dir('lua/dtomvan/config/null-ls/*.lua')
    end,
    cond = function()
        return not vim.g.started_by_firenvim
    end,
}
