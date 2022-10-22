local substitute = require 'substitute'
local exchange = require 'substitute.exchange'
substitute.setup {}
vim.keymap.set('n', '<c-l>', substitute.operator)
vim.keymap.set('n', '<c-l><c-l>', substitute.line)
vim.keymap.set('n', '<c-s-l>', substitute.eol)
vim.keymap.set('x', '<c-l>', substitute.visual)
vim.keymap.set('n', '<c-l>x', exchange.operator)
vim.keymap.set('n', '<c-l>xx', exchange.line)
vim.keymap.set('x', '<c-l>X', exchange.visual)
vim.keymap.set('n', '<c-l>xc', exchange.cancel)
