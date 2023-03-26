return {
    'TimUntersberger/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    cmd = 'Neogit',
    keys = {
        { '<leader>gst', '<cmd>Neogit<cr>', desc = 'Open Neogit status' },
        {
            '<leader>gc',
            '<cmd>Neogit commit kind=vsplit<cr>',
            desc = 'Commit with Neogit',
        },
        {
            '<leader>gh',
            function()
                vim.cmd.vnew()
                vim.cmd.vie(vim.fn.stdpath 'config' .. '/help/neogit.md')
                vim.opt_local.buftype = 'nofile'
                vim.opt_local.bufhidden = 'hide'
                vim.opt_local.swapfile = false
                vim.keymap.set('n', 'q', '<cmd>q<cr>', { buffer = true })
            end,
            desc = 'Neogit help',
        },
    },
    opts = {
        integrations = {
            diffview = true,
        },
    },
}
