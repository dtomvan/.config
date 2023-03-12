vim.keymap.set(
    'n',
    '<leader>sb',
    '<cmd>vs term://stack build<cr>',
    require('dtomvan.keymaps').noremap 'Stack build'
)
