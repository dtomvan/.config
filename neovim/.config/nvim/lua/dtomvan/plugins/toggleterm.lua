return {
    'numToStr/FTerm.nvim',
    opts = {
        border = 'rounded',
        dimensions = {
            height = 0.9,
            width = 0.9,
        },
        blend = 20,
    },
    keys = {
        {
            '<A-i>',
            function()
                require('FTerm').toggle()
            end,
            mode = { 'n', 't' },
            desc = 'Toggle terminal',
        },
    },
}
