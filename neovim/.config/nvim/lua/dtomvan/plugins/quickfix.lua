return {
    {
        'ashfinal/qfview.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'gabrielpoca/replacer.nvim',
        opts = {},
        keys = function(plug)
            return {
                { '<leader>qf', function()
                    require 'replacer'.run(plug.opts)
                end },
                { '<leader>qs', function()
                    require 'replacer'.save(plug.opts)
                end },
            }
        end,
    },
}
