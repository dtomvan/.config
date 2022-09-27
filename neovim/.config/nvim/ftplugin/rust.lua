local buffer = require('dtomvan.keymaps').buffer
vim.keymap.set('n', 'J', require('rust-tools.join_lines').join_lines, buffer 'Join lines')
vim.keymap.set(
    'n',
    '<leader>l',
    require('rust-tools.hover_actions').hover_actions,
    buffer 'Rust analyzer hover actions'
)
vim.keymap.set(
    'n',
    '<leader>t',
    require('rust-tools.open_cargo_toml').open_cargo_toml,
    buffer 'Open Cargo.toml which the current rust file belongs to.'
)
