local keymaps = require 'dtomvan.keymaps'

vim.keymap.set(
    'n',
    'a',
    '<cmd>OverseerRun<cr>',
    keymaps.silent('Run...', { buffer = true })
)
