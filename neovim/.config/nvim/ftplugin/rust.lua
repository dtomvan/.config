vim.keymap.set('n', 'J', require('rust-tools.join_lines').join_lines, buffer)
vim.keymap.set('n', '<leader>l', require('rust-tools.hover_actions').hover_actions, buffer)
vim.keymap.set('n', '<leader>t', require('rust-tools.open_cargo_toml').open_cargo_toml, buffer)
