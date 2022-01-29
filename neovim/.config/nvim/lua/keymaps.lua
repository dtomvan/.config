local mapx = require 'mapx'

mapx.map('<leader>', '<Nop>', 'silent')

-- Window management
mapx.nnoremap('<C-S-Left>', '<C-w><C-H>', 'silent')
mapx.nnoremap('<C-S-Down>', '<C-w><C-J>', 'silent')
mapx.nnoremap('<C-S-Up>', '<C-w><C-K>', 'silent')
mapx.nnoremap('<C-S-Right>', '<C-w><C-L>', 'silent')
mapx.nnoremap('<C-Left>', ':vertical resize -2<CR>', 'silent')
mapx.nnoremap('<C-Right>', ':vertical resize +2<CR>', 'silent')
mapx.nnoremap('<C-Up>', ':resize -2<CR>', 'silent')
mapx.nnoremap('<C-Down>', ':resize +2<CR>', 'silent')

-- Telescope
mapx.nnoremap('<leader>b', "<cmd>lua R('telescopepickers').buffers()<cr>", 'silent')
mapx.nnoremap('<leader>ca', "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>", 'silent')
mapx.nnoremap('<leader>ch', "<cmd>lua require('telescope.builtin').command_history()<cr>", 'silent')
mapx.nnoremap('<leader>dd', ":lua R('telescopepickers').dotfiles()<CR>", 'silent')
mapx.nnoremap('<leader>fc', "<cmd>lua require('telescope.builtin').commands()<cr>", 'silent')
mapx.nnoremap('<leader>fd', "<cmd>lua require('telescopepickers').configs()<cr>", 'silent')
mapx.nnoremap('<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'silent')
mapx.nnoremap('<leader>fp', "<cmd>lua require('telescopepickers').projects()<cr>", 'silent')
mapx.nnoremap('<leader>ft', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", 'silent')
mapx.nnoremap('<leader>q', ":lua R('telescope.builtin').diagnostics()<cr>", 'silent')
mapx.nnoremap('<leader>id', "<cmd>r !date +'%F'<CR>", 'silent')
mapx.nnoremap(
    '<C-e>',
    ":lua require'telescope.builtin'.find_files{find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' }}<cr>",
    'silent'
)
mapx.nnoremap('<C-p>', "<cmd>lua R('telescopepickers').grep()<cr>", 'silent')

-- Quick terminals
mapx.nnoremap('<leader>cl', ':vs term://$SHELL<cr>i', 'silent')
mapx.nnoremap('<leader>cr', ':vs term://mold -run cargo run<CR>10<C-w>>', 'silent')
mapx.nnoremap('<leader>cb', ':vs term://mold -run cargo b<CR>10<C-w>>', 'silent')
mapx.nnoremap('<leader>cc', ':vs term://mold -run cargo clippy<CR>10<C-w>>', 'silent')
mapx.nnoremap('<leader>ct', ':vs term://mold -run cargo t<CR>10<C-w>>', 'silent')

-- Edge cases
mapx.nnoremap('<leader><leader>', ':<up>', 'silent')
mapx.nnoremap('<leader><CR>', '<C-w>w', 'silent')
mapx.nnoremap('<C-q>', ":lua require'telescope'.extensions.project.project{}<CR>", 'silent')

-- Thanks prime (:
local breakpoints = { ',', '!', '.', '?', ';' }
for _, point in ipairs(breakpoints) do
    mapx.inoremap(point, point .. '<c-g>u', 'silent')
end
