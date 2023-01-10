return {
    'jose-elias-alvarez/null-ls.nvim',
    event = "BufReadPost",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local ok, null_ls = pcall(require, 'null-ls')
        if not ok then
            return
        end

        local formatting = null_ls.builtins.formatting

        null_ls.setup {
            sources = {
                formatting.stylua,
                formatting.taplo,
                formatting.black,
            },
            on_attach = require 'dtomvan.lsp.opts'.on_attach,
        }

        for _, source in ipairs(vim.api.nvim_get_runtime_file('lua/dtomvan/config/null-ls/*.lua', true)) do
            loadfile(source)()
        end
    end,
}
