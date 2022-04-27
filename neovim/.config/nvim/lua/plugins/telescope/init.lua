local silent = require('keymaps').silent

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

-- Custom pickers
vim.keymap.set('n', '<C-e>', require('telescope.builtin').fd, silent)
vim.keymap.set('n', '<C-p>', R('plugins.telescope.pickers').grep, silent)
vim.keymap.set('n', '<leader>b', R('plugins.telescope.pickers').buffers, silent)
vim.keymap.set('n', '<leader>dd', R('plugins.telescope.pickers').dotfiles, silent)
vim.keymap.set('n', '<leader>fb', R('plugins.telescope.pickers').current_buffer, silent)
vim.keymap.set('n', '<leader>fd', R('plugins.telescope.pickers').configs, silent)
vim.keymap.set('n', '<leader>fp', R('plugins.telescope.pickers').projects, silent)
vim.keymap.set('n', '<leader>q', R('plugins.telescope.pickers').diagnostics, silent)
-- Builtin pickers
vim.keymap.set('n', '<leader>ch', require('telescope.builtin').command_history, silent)
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands, silent)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, silent)
vim.keymap.set('n', '<leader>ft', require('telescope.builtin').lsp_workspace_symbols, silent)
