return {
    'nvim-neo-tree/neo-tree.nvim',
    version = 'v2.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-tree/nvim-web-devicons', name = 'nvim-tree-devicons' },
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '<f1>', '<cmd>Neotree toggle reveal right<cr>', silent = true },
        { '<leader>nt', ':Neotree toggle reveal right ' },
    },
    init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        vim.fn.sign_define(
            'DiagnosticSignError',
            { text = ' ', texthl = 'DiagnosticSignError' }
        )
        vim.fn.sign_define(
            'DiagnosticSignWarn',
            { text = ' ', texthl = 'DiagnosticSignWarn' }
        )
        vim.fn.sign_define(
            'DiagnosticSignInfo',
            { text = ' ', texthl = 'DiagnosticSignInfo' }
        )
        vim.fn.sign_define(
            'DiagnosticSignHint',
            { text = '', texthl = 'DiagnosticSignHint' }
        )
    end,
    opts = {
        close_if_last_window = true,
        use_libuv_file_watcher = true,
        follow_current_file = true,
        source_selector = {
            winbar = true,
            statusline = false,
        },
    },
}
