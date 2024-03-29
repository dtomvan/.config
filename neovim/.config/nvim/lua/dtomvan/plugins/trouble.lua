local opts = { skip_groups = true, jump = true }

return {
    {
        'folke/trouble.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
        config = true,
        lazy = true,
        cmd = {
            'Trouble',
            'TroubleClose',
            'TroubleToggle',
            'TroubleRefresh',
        },
        keys = {
            {
                '<leader>xx',
                '<cmd>TroubleToggle<cr>',
                desc = 'Toggle trouble.nvim',
            },
            {
                '<leader>xw',
                '<cmd>TroubleToggle workspace_diagnostics<cr>',
                desc = 'View workspace diagnostics in trouble.nvim',
            },
            {
                '<leader>xd',
                '<cmd>TroubleToggle document_diagnostics<cr>',
                desc = 'View document diagnostics in trouble.nvim',
            },
            {
                '<leader>xq',
                '<cmd>TroubleToggle quickfix<cr>',
                desc = 'View quickfix list in trouble.nvim',
            },
            {
                '<leader>xl',
                '<cmd>TroubleToggle loclist<cr>',
                desc = 'View loclist in trouble.nvim',
            },
            {
                'gR',
                '<cmd>TroubleToggle lsp_references<cr>',
                desc = 'Show LSP references in trouble.nvim',
            },
            {
                '<leader>xj',
                function()
                    require('trouble').next(opts)
                end,
                desc = 'Jump to next trouble.nvim item',
            },
            {
                '<leader>xk',
                function()
                    require('trouble').previous(opts)
                end,
                desc = 'Jump to previous trouble.nvim item',
            },
            {
                '<leader>xJ',
                function()
                    require('trouble').last(opts)
                end,
                desc = 'Jump to last trouble.nvim item',
            },
            {
                '<leader>xK',
                function()
                    require('trouble').first(opts)
                end,
                desc = 'Jump to first trouble.nvim item',
            },
        },
    },
}
