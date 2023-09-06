return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
    },
    cmd = 'ToggleTerm',
    keys = {
        {
            '<A-i>',
            vim.cmd.ToggleTerm,
            mode = { 'n', 't' },
            desc = 'Toggle terminal',
        },
    },
}
