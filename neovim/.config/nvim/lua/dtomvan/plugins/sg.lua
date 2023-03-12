return {
    {
        'tjdevries/sg.nvim',
        event = 'BufReadPre',
        build = 'cargo build --workspace',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            {
                '<leader>gsg',
                "<cmd>lua require'sg.telescope'.fuzzy_search_results()<CR>",
            },
        },
        config = {
            on_attach = require 'dtomvan.lsp.attach',
        },
    },
}
