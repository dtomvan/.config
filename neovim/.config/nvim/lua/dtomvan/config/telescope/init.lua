local telescope = require 'telescope'
local load = telescope.load_extension

local noremap = require('dtomvan.keymaps').noremap
local pickers = require 'dtomvan.config.telescope.pickers'

load 'undo'
load 'fzy_native'

-- Custom pickers
vim.keymap.set('n', '<leader>B', pickers.buffers, noremap 'Select a buffer')
vim.keymap.set(
    'n',
    '<leader>dd',
    pickers.dotfiles,
    noremap 'Search through ~/Dotfiles'
)
vim.keymap.set(
    'n',
    '<leader>fb',
    pickers.current_buffer,
    noremap 'Current buffer fuzzy'
)
vim.keymap.set(
    'n',
    '<leader>fd',
    pickers.configs,
    noremap 'Search hidden files'
)
vim.keymap.set(
    'n',
    '<leader>fp',
    pickers.projects,
    noremap 'Telescope a directory'
)
vim.keymap.set(
    'n',
    '<leader>q',
    pickers.diagnostics,
    noremap 'Search through (LSP) diagnostics'
)
