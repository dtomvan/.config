autocmd BufEnter *.rs nnoremap <buffer> J :lua require'rust-tools.join_lines'.join_lines()<CR>
autocmd BufEnter *.rs nnoremap <buffer> <leader>l :lua require'rust-tools.hover_actions'.hover_actions()<cr>
autocmd BufEnter *.rs nnoremap <buffer> <leader>t :lua require'rust-tools.open_cargo_toml'.open_cargo_toml()<cr>
autocmd BufWritePre :silent lua vim.lsp.buf.formatting()
autocmd BufEnter *.hs nnoremap <leader>sb :!stack build<cr>
autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            \ |   exe "normal! g`\""
            \ | endif
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" Handy for dates in your commit message
au BufEnter */COMMIT_EDITMSG vmap <buffer> <leader>0 d:r! date +\%Y-\%m-\%d<cr>VK<esc>

hi TabLineFill guibg=#333333
hi StatusLine guibg=#928374 guifg=#3c3836

let mapleader = "\<Space>"
set clipboard=unnamedplus
command! -nargs=* Ca !cargo <args>
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
cnoreabbrev luf luafile
cnoreabbrev fcd cd %:p:h

" move line(s) up/down
nno <silent> <leader>k :m-2<CR>==
nno <silent> <leader>j :m+<CR>==
nno <leader>y mpggyG`p
nno J mzJ`z
nno J mzJ`z
nno <silent> <leader>j :cnext<CR>
nno <silent> <leader>k :cprev<CR>
nno <silent> \a :lua require("harpoon.mark").add_file()<CR>
nno <silent> <F1> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nno <silent> <C-Space> :lua require("harpoon.ui").nav_file(1)<CR>
nno <silent> <C-c> :lua require("harpoon.ui").nav_file(2)<CR>
nno <silent> <C-y> :lua require("harpoon.ui").nav_file(3)<CR>
nno <silent> <C-h> :lua require("harpoon.ui").nav_file(4)<CR>
nno <leader>x :silent !chmod +x %<CR>
nno <silent> <leader>n :noh<cr>
nno <leader>s :so %<cr>
nno p p==

vno <leader>s :!sort<cr>
vno <silent> J :m '>+1<CR>gv=gv
vno <silent> K :m '<-2<CR>gv=gv
vno <silent> <leader>k :m-2<CR>gv=gv
vno <silent> <leader>j :m'>+<CR>gv=gv
vno <c-a> do<esc>p0!!bc<cr>kJgv
