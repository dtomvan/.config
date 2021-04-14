local map = vim.api.nvim_set_keymap
map('n',
    'k',
    "gk",
    {noremap = true, silent = true}
)
map('n',
    'j',
    "gj",
    {noremap = true, silent = true}
)
vim.cmd [[nnoremap <silent> gj :let _=&lazyredraw<CR>:set lazyredraw<CR>/\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>]]
vim.cmd [[nnoremap <silent> gk :let _=&lazyredraw<CR>:set lazyredraw<CR>?\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>]]
map('n',
    '<Space><Space>',
    ":<up>",
    {noremap = true, silent = false}
)
map('n',
    '<C-k>',
    "<C-w><",
    {noremap = false, silent = true}
)
map('n',
    '<C-j>',
    "<C-w>>",
    {noremap = false, silent = true}
)
map('n',
    '<C-S-Left>',
    "<C-w><C-H>",
    {noremap = true, silent = true}
)
map('n',
    '<C-S-Down>',
    "<C-w><C-J>",
    {noremap = true, silent = true}
)
map('n',
    '<C-S-Up>',
    "<C-w><C-K>",
    {noremap = true, silent = true}
)
map('n',
    '<C-S-Right>',
    "<C-w><C-L>",
    {noremap = true, silent = true}
)
map('n',
    '<C-n>',
    ":NvimTreeToggle<CR>",
    {noremap = true, silent = true}
)
map('n',
    '<F8>',
    ":TagbarToggle<CR>",
    {noremap = false, silent = true}
)
map('n',
    '<Space>a',
    "<cmd>lua vim.lsp.buf.code_action()<CR>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>b',
    "<cmd>lua require('telescope.builtin').buffers()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>ca',
    "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>ch',
    "<cmd>lua require('telescope.builtin').command_history()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>cr',
    ":vs term://cargo run<CR>10<C-w>>",
    {noremap = false, silent = false}
)
map('n',
    '<Space>cb',
    ":vs term://cargo b<CR>10<C-w>>",
    {noremap = false, silent = false}
)
map('n',
    '<Space>cc',
    ":vs term://cargo check<CR>10<C-w>>",
    {noremap = false, silent = false}
)
map('n',
    '<Space>ct',
    ":vs term://cargo t<CR>10<C-w>>",
    {noremap = false, silent = false}
)
map('n',
    '<Space>d',
    "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>f',
    ":RustFmt<CR>",
    {noremap = false, silent = true}
)
map('n',
    '<Space>fh',
    "<cmd>lua require('telescope.builtin').help_tags()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>fc',
    "<cmd>lua require('telescope.builtin').commands()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>ft',
    "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>id',
    "<cmd>r !date +\'%F\'<CR>",
    {noremap = true, silent = true}
)
map('n',
    '<C-e>',
    "<cmd>lua require('telescope.builtin').find_files()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<C-p>',
    "<cmd>lua require('telescope.builtin').live_grep()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '\\',
    "<Plug>(easymotion-prefix)",
    {noremap = false, silent = true}
)
map('n',
    '<C-cr>',
    "<C-w>w",
    {noremap = false, silent = true}
)
map('n',
    '<silent>',
    "<Left> :vertical resize -2<CR>",
    {noremap = false, silent = true}
)
map('n',
    '<silent>',
    "<Right> :vertical resize +2<CR>",
    {noremap = false, silent = true}
)
map('n',
    '<silent>',
    "<Up> :resize -2<CR>",
    {noremap = false, silent = true}
)
map('n',
    '<silent>',
    "<Down> :resize +2<CR>",
    {noremap = false, silent = true}
)
map('i',
    '<tab>',
    "<Plug>(completion_smart_tab)",
    {noremap = false, silent = true}
)
map('i',
    '<s-tab>',
    "<Plug>(completion_smart_s_tab)",
    {noremap = false, silent = true}
)
map('i',
    '<silent>',
    "<c-p> <Plug>(completion_trigger)",
    {noremap = false, silent = true}
)
map('v',
    '<A-c>',
    "\"+y",
    {noremap = true, silent = false}
)
map('n',
    '<A-v>',
    "\"+p",
    {noremap = true, silent = false}
)
map(
    'n',
    '<C-q>',
    ":lua require'telescope'.extensions.project.project{}<CR>",
    {noremap = true, silent = false}
)
