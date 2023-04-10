-- local norexpr = require('dtomvan.keymaps').norexpr
local noremap = require('dtomvan.keymaps').noremap
vim.opt_local.cole = 1
vim.opt_local.spell = false

vim.keymap.set('n', '<c-f>', require 'dtomvan.formatter'.format_buf)
vim.keymap.set('i', '<c-f>', function()
    local name = vim.fn.getline '.'
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row - 1, row, true, {})
    vim.fn.jobstart(
        { 'inkscape-figures', 'create', name, vim.b.vimtex.root .. '/figures/' },
        {
            on_stdout = function(_, data)
                if not data then
                    return
                end
                vim.api.nvim_buf_set_lines(0, row, row, false, data)
            end,
            on_exit = function(_, code)
                if code ~= 0 then
                    vim.notify 'failed to run inkscape-figures'
                else
                    vim.api.nvim_buf_set_lines(0, row - 1, row, true, {})
                end
            end,
        }
    )
end, noremap 'Create new figure')

vim.keymap.set('n', '\\lf', function()
    vim.fn.jobstart {
        'inkscape-figures',
        'edit',
        vim.b.vimtex.root .. '/figures/',
    }
end, noremap 'Edit figure...')
