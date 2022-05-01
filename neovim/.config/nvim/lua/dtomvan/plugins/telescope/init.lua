local silent = require('dtomvan.keymaps').silent

require('telescope').setup {
    defaults = {
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
require('telescope').load_extension 'fzy_native'

local pickers = R 'dtomvan.plugins.telescope.pickers'

-- Custom pickers
vim.keymap.set('n', '<C-p>', pickers.grep, silent)
vim.keymap.set('n', '<leader>b', pickers.buffers, silent)
vim.keymap.set('n', '<leader>dd', pickers.dotfiles, silent)
vim.keymap.set('n', '<leader>fb', pickers.current_buffer, silent)
vim.keymap.set('n', '<leader>fd', pickers.configs, silent)
vim.keymap.set('n', '<leader>fp', pickers.projects, silent)
vim.keymap.set('n', '<leader>q', pickers.diagnostics, silent)
-- Builtin pickers
vim.keymap.set('n', '<leader>ch', require('telescope.builtin').command_history, silent)
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands, silent)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, silent)
vim.keymap.set('n', '<leader>ft', require('telescope.builtin').lsp_workspace_symbols, silent)
vim.keymap.set('n', '<C-e>', require('telescope.builtin').fd, silent)
vim.keymap.set('n', '<leader>/', require('telescope.builtin').help_tags, silent)
