return {
    'folke/zen-mode.nvim',
    dependencies = {
        {
            'folke/twilight.nvim',
            config = true,
        },
    },
    cmd = 'ZenMode',
    opts = {
        window = {
            options = {
                concealcursor = 'n',
                conceallevel = 3,
                cursorcolumn = false,
                cursorline = false,
                foldcolumn = '0',
                list = false,
                number = false,
                relativenumber = false,
                signcolumn = 'no',
                statusline = ' ',
            },
        },
        on_open = function()
            _G.rerun_noice = require('noice.config').is_running()
            require('noice').disable()
        end,
        on_close = function()
            if _G.rerun_noice then
                require('noice').enable()
            end
        end,
    },
}
