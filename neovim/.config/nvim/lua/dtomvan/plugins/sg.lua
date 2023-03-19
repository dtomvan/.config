return {
    {
        'tjdevries/sg.nvim',
        build = 'cargo build --workspace',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            {
                '<leader>gsg',
                "<cmd>lua require'sg.telescope'.fuzzy_search_results()<CR>",
            },
        },
        opts = function()
            return {
                on_attach = require 'dtomvan.lsp.attach',
            }
        end,
    },
}
