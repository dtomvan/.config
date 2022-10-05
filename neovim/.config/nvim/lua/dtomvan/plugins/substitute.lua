local substitute = require 'substitute'
local exchange = require 'substitute.exchange'
substitute.setup {}
vim.keymap.set('n', '<c-a>', substitute.operator)
vim.keymap.set('n', '<c-a><c-a>', substitute.line)
vim.keymap.set('n', '<c-s-a>', substitute.eol)
vim.keymap.set('x', '<c-a>', substitute.visual)
vim.keymap.set('n', '<c-a>x', exchange.operator)
vim.keymap.set('n', '<c-a>xx', exchange.line)
vim.keymap.set('x', '<c-a>X', exchange.visual)
vim.keymap.set('n', '<c-a>xc', exchange.cancel)
