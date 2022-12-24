return {
    'fhill2/xplr.nvim',
    build = function()
        require('xplr').install { hide = true }
        R 'dtomvan.plugins.xplr'
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
    },
}
