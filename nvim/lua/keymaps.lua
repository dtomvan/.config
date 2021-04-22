local map = API.nvim_set_keymap
map('', '<Space>', "<Nop>", {noremap = true, silent = true})
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
vim.cmd [[imap <C-k> <Plug>(neosnippet_expand_or_jump)]]
vim.cmd [[smap <C-k> <Plug>(neosnippet_expand_or_jump)]]
vim.cmd [[xmap <C-k> <Plug>(neosnippet_expand_target)]]
map('',
    '<Down>',
    "j<C-e>",
    {noremap = true, silent = false}
)
map('',
    '<Up>',
    "k<C-y>",
    {noremap = true, silent = false}
)
map('n',
    '<Space><Space>',
    ":<up>",
    {noremap = true, silent = false}
)
map('n',
    '<C-k>',
    "<C-w>2<",
    {noremap = false, silent = true}
)
map('n',
    '<C-j>',
    "<C-w>2>",
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
    "<cmd>lua R('telescopepickers').buffers()<cr>",
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
    '<Space>fp',
    "<cmd>lua require('telescopepickers').projects()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>fd',
    "<cmd>lua require('telescopepickers').configs()<cr>",
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
    '<Space>cso',
    ":lua package.loaded.onebuddy = nil<cr>:lua require'colorbuddy'.colorscheme('onebuddy')<cr>",
    {noremap = false, silent = false}
)
map('n',
    '<Space>csg',
    ":lua package.loaded.gruvbuddy = nil<cr>:lua require'colorbuddy'.colorscheme('gruvbuddy')<cr>",
    {noremap = false, silent = false}
)
map('n',
    '<Space>t',
    ":Ttoggle<cr>",
    {noremap = false, silent = false}
)
map('n',
    '<Space>q',
    "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>dd',
    ":lua R('telescopepickers').dotfiles()<CR>",
    {noremap = true, silent = true}
)
map('n',
    '<Space>dg',
    ":lua R('telescopepickers').gitclient()<CR>",
    {noremap = true, silent = true}
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
    "<cmd>lua R('telescopepickers').grep()<cr>",
    {noremap = true, silent = true}
)
map('n',
    '\\',
    "<Plug>(easymotion-prefix)",
    {noremap = false, silent = true}
)
map('n',
    '<Space><CR>',
    "<C-w>w",
    {noremap = true, silent = false}
)
map('n',
    '<C-Left>',
    ":vertical resize -2<CR>",
    {noremap = false, silent = true}
)
map('n',
    '<C-Right>',
    ":vertical resize +2<CR>",
    {noremap = false, silent = true}
)
map('n',
    '<C-Up>',
    ":resize -2<CR>",
    {noremap = false, silent = true}
)
map('n',
    '<C-Down>',
    ":resize +2<CR>",
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
map(
    'n',
    '<C-q>',
    ":lua require'telescope'.extensions.project.project{}<CR>",
    {noremap = true, silent = false}
)
