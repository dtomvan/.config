return {
    'j-morano/buffer_manager.nvim',
    config = function()
        vim.g.buffer_manager_log_level = 'fatal'
    end,
    keys = {
        {
            '<c-b>',
            function()
                require('buffer_manager.ui').toggle_quick_menu()
            end,
            desc = 'Buffer manager',
        },
    },
}
