vim.cmd [[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd [[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
vim.cmd [[autocmd ColorScheme * hi! link LspDiagnosticsUnderlineError SpellCap]]
vim.cmd [[autocmd ColorScheme * hi! link LspDiagnosticsUnderlineWarning SpellBad]]
vim.cmd [[autocmd ColorScheme * hi! link LspDiagnosticsUnderlineHint SpellRare]]
vim.cmd [[hi TabLineFill guibg=#333333]]
vim.cmd [[hi! link LspDiagnosticsUnderlineInformation SpellRare]]
vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.cmd [[command B buffers]]
vim.cmd [[command Md set syntax=markdown]]
vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]
vim.cmd [[autocmd BufEnter * set number]]
vim.cmd [[autocmd BufEnter * set relativenumber]]
vim.cmd [[let mapleader = "\<Space>"]]
vim.cmd [[let g:completion_enable_auto_popup = 1]]
vim.cmd [[let g:lightline = {'colorscheme': 'wombat'}]]
vim.cmd [[hi StatusLine guibg=#928374 guifg=#3c3836]]
vim.cmd [[filetype plugin on]]
vim.cmd [[syntax enable]]
vim.cmd [[filetype plugin indent on]]
vim.cmd [[syntax on]]
