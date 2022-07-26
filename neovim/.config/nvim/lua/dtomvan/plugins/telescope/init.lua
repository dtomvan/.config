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
local ivy = require('telescope.themes').get_ivy {}

-- Custom pickers
vim.keymap.set('n', '<C-p>', pickers.grep)
vim.keymap.set('n', '<leader>b', pickers.buffers)
vim.keymap.set('n', '<leader>dd', pickers.dotfiles)
vim.keymap.set('n', '<leader>fb', pickers.current_buffer)
vim.keymap.set('n', '<leader>fd', pickers.configs)
vim.keymap.set('n', '<leader>fp', pickers.projects)
vim.keymap.set('n', '<leader>q', pickers.diagnostics)
-- Builtin pickers
vim.keymap.set('n', '<leader>:', function()
    require('telescope.builtin').command_history(ivy)
end)
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands)
vim.keymap.set('n', '<leader>ft', require('telescope.builtin').lsp_workspace_symbols)
vim.keymap.set('n', '<C-e>', require('telescope.builtin').fd)
vim.keymap.set('n', '<leader>h', require('telescope.builtin').help_tags)

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)
vim.keymap.set('n', '<leader>/', function()
    require('telescope.builtin').current_buffer_fuzzy_find(ivy)
end)
