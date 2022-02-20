autocmd TermOpen * setlocal nonumber norelativenumber
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
au BufEnter */COMMIT_EDITMSG nmap <silent> <buffer> <leader>0 V/# Please enter the commit message/-1<cr>d:call histdel('/', -1)<cr>:r! date +\%Y-\%m-\%d<cr>VK<esc>
au BufEnter *.tsv setlocal noexpandtab textwidth=0
au BufEnter *.tsv nmap <silent> <buffer> <leader>0 <cmd>!cat % \| xclip -sel clip<cr>
au BufEnter *.tsv vmap <silent> <buffer> <leader>9 <cmd>'<,'>s/\(.*\)	\(.*\)/\2	\1<cr>

" Set line numbers for documentation
augroup vim help
    autocmd!
    autocmd FileType help setlocal number
    autocmd FileType help setlocal relativenumber
augroup END

hi TabLineFill guibg=#333333
hi StatusLine guibg=#928374 guifg=#3c3836

let mapleader = "\<Space>"
command! -nargs=* Ca !cargo <args>
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
cnoreabbrev luf luafile
cnoreabbrev fcd cd %:p:h

vno <leader>s :!sort<cr>
vno <silent> J :m '>+1<CR>gv=gv
vno <silent> K :m '<-2<CR>gv=gv
vno <silent> <leader>k :m-2<CR>gv=gv
vno <silent> <leader>j :m'>+<CR>gv=gv
vno <c-a> do<esc>p0!!bc<cr>kJgv
