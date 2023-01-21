vim.cmd.start()
vim.keymap.set('i', '<esc>', '<esc><cmd>wq<cr>', { buffer = true, silent = true })
vim.keymap.set(
    'i',
    '<cr>',
    '<esc><cmd>w<cr><cmd>call firenvim#press_keys("<LT>CR>")<cr>ggdGa',
    { buffer = true, silent = true }
)
vim.keymap.set('i', '<s-cr>', '<cr>', { buffer = true })

vim.o.laststatus = 0

vim.o.filetype = 'markdown'
