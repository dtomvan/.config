local telescope = require 'telescope'
local load = telescope.load_extension
local builtin = require 'telescope.builtin'
local ivy = require('telescope.themes').get_ivy {}

local trouble = require('trouble.providers.telescope').open_with_trouble

local noremap = require('dtomvan.keymaps').noremap
local pickers = require 'dtomvan.config.telescope.pickers'

telescope.setup {
    defaults = {
        mappings = {
            i = { ['<c-s-t>'] = trouble },
            n = { ['<c-s-t>'] = trouble },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--multiline',
            '--vimgrep',
            '--pcre2',
            '--smart-case',
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },
    },
}

load 'fzy_native'
load 'file_browser'

-- Custom pickers
vim.keymap.set('n', '<C-p>', pickers.grep, noremap 'Grep over CWD files')
vim.keymap.set('n', '<leader>B', pickers.buffers, noremap 'Select a buffer')
vim.keymap.set('n', '<leader>dd', pickers.dotfiles, noremap 'Search through ~/Dotfiles')
vim.keymap.set('n', '<leader>fb', pickers.current_buffer, noremap 'Current buffer fuzzy')
vim.keymap.set('n', '<leader>fd', pickers.configs, noremap 'Search hidden files')
vim.keymap.set('n', '<leader>fp', pickers.projects, noremap 'Telescope a directory')
vim.keymap.set('n', '<leader>q', pickers.diagnostics, noremap 'Search through (LSP) diagnostics')

-- Builtin pickers
vim.keymap.set('n', '<leader>:', function()
    builtin.command_history(ivy)
end, noremap 'Command history')
vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(ivy)
end, noremap 'Swiper')
vim.keymap.set('n', '<M-x>', builtin.commands, noremap 'Telescope user commands')
vim.keymap.set('n', '<leader>ft', builtin.lsp_workspace_symbols, noremap 'Telescope workspace symbols')
vim.keymap.set('n', '<C-e>', builtin.fd, noremap 'File search')
vim.keymap.set('n', '<leader>h', builtin.help_tags, noremap 'Telescope help files')

vim.keymap.set('n', '<leader>?', builtin.oldfiles, noremap 'File history')
vim.keymap.set('n', '<leader>;', builtin.resume, noremap 'Reopen prev Telescope')
