return {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPost',
    dependencies = {
        'jay-babu/mason-null-ls.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-lua/lsp-status.nvim',
    },
    config = function()
        require('null-ls').setup {
            on_attach = require 'dtomvan.lsp.attach_handler',
        }
        for _, source in ipairs(vim.api.nvim_get_runtime_file(
            'lua/dtomvan/config/null-ls/*.lua',
            true
        )) do
            loadfile(source)()
        end
    end,
    cond = function()
        return not vim.g.started_by_firenvim
    end,
}
