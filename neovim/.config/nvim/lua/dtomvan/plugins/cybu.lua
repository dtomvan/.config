return {
    'ghillb/cybu.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
    },

    config = function()
        local cybu = require 'cybu'
        cybu.setup {
            style = {
                highlights = {
                    current_buffer = 'CybuFocus',
                    adjacent_buffers = 'NormalFloat',
                    background = 'NormalFloat',
                    border = 'WinSeparator',
                },
            },
        }
        local function c(dir)
            return function()
                cybu.cycle(dir)
            end
        end

        vim.keymap.set({ 'n', 'v' }, '<s-tab>', c 'prev')
        vim.keymap.set({ 'n', 'v' }, '<tab>', c 'next')
    end,
}
