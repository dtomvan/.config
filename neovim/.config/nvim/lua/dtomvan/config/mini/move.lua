local move = require 'mini.move'
move.setup {
    mappings = {
        line_left  = '',
        line_down  = '',
        line_up    = '',
        line_right = '',
    }
}

local s = require 'dtomvan.utils.func'.set_first
local go = s(s, move.move_line)
vim.keymap.set('i', '<M-h>', go 'left')
vim.keymap.set('i', '<M-j>', go 'down')
vim.keymap.set('i', '<M-k>', go 'up')
vim.keymap.set('i', '<M-l>', go 'right')
