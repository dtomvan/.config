vim.keymap.set('v', '<Leader><bslash>', '<cmd>EasyAlign*<bar><cr>', {
    desc = 'Easy align markdown tables',
    buffer = true,
    remap = true,
    silent = true,
})
vim.opt_local.list = false
