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

local noremap = require('dtomvan.keymaps').noremap
local pickers = R 'dtomvan.config.telescope.pickers'
local ivy = require('telescope.themes').get_ivy {}

-- Custom pickers
vim.keymap.set('n', '<C-p>', pickers.grep, noremap 'Grep over CWD files')
vim.keymap.set('n', '<leader>b', pickers.buffers, noremap 'Select a buffer')
vim.keymap.set('n', '<leader>dd', pickers.dotfiles, noremap 'Search through ~/Dotfiles')
vim.keymap.set('n', '<leader>fb', pickers.current_buffer, noremap 'Current buffer fuzzy')
vim.keymap.set('n', '<leader>fd', pickers.configs, noremap 'Search hidden files')
vim.keymap.set('n', '<leader>fp', pickers.projects, noremap 'Telescope a directory')
vim.keymap.set('n', '<leader>q', pickers.diagnostics, noremap 'Search through (LSP) diagnostics')
-- Builtin pickers
vim.keymap.set('n', '<leader>:', function()
    require('telescope.builtin').command_history(ivy)
end, noremap 'Command history')
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands, noremap 'Telescope EX commands')
vim.keymap.set(
    'n',
    '<leader>ft',
    require('telescope.builtin').lsp_workspace_symbols,
    noremap 'Telescope workspace symbols'
)
vim.keymap.set('n', '<C-e>', require('telescope.builtin').fd, noremap 'File search')
vim.keymap.set('n', '<leader>h', require('telescope.builtin').help_tags, noremap 'Telescope help files')

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, noremap 'File history')
vim.keymap.set('n', '<leader>/', function()
    require('telescope.builtin').current_buffer_fuzzy_find(ivy)
end, noremap 'Swiper')
vim.keymap.set('n', '<leader>;', require('telescope.builtin').resume, noremap 'Reopen prev Telescope')
