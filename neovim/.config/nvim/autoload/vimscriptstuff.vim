" Too much wizardry for me to convert that to lua
autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            \ |   exe "normal! g`\""
            \ | endif
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" Handy for dates in your commit message
au BufEnter */COMMIT_EDITMSG vmap <buffer> <leader>0 d:r! date +\%Y-\%m-\%d<cr>VK<esc>
au BufEnter */COMMIT_EDITMSG nmap <silent> <buffer> <leader>0 V/# Please enter the commit message/-1<cr>d:call histdel('/', -1)<cr>:r! date +\%Y-\%m-\%d<cr>VK<esc>
au FileType NeogitCommitMessage nmap <silent> <buffer> <leader>0 V/# /-1<cr>d:call histdel('/', -1)<cr>:r! date +\%Y-\%m-\%d<cr>VK<esc>
au BufEnter *.tsv setlocal noexpandtab textwidth=0
au BufEnter *.tsv nmap <silent> <buffer> <leader>0 <cmd>!cat % \| xclip -sel clip<cr>
au BufEnter *.tsv vmap <silent> <buffer> <leader>9 <cmd>'<,'>s/\(.*\)	\(.*\)/\2	\1<cr>

hi TabLineFill guibg=#333333
hi WinSeparator guibg=NONE

cnoreabbrev luf luafile
cnoreabbrev fcd cd %:p:h

command! -nargs=+ Rg execute 'silent grep! <args>' | copen

highlight WinSeparator guibg=NONE
