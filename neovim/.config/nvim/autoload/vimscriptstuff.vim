" Handy for dates in your commit message
au BufEnter */COMMIT_EDITMSG vmap <buffer> <leader>0 d:r! date +\%Y-\%m-\%d<cr>VK<esc>
au BufEnter */COMMIT_EDITMSG nmap <silent> <buffer> <leader>0 V/# Please enter the commit message/-1<cr>d:call histdel('/', -1)<cr>:r! date +\%Y-\%m-\%d<cr>VK<esc>
au FileType NeogitCommitMessage nmap <silent> <buffer> <leader>0 V/# /-1<cr>d:call histdel('/', -1)<cr>:r! date +\%Y-\%m-\%d<cr>VK<esc>

cnoreabbrev luf luafile
cnoreabbrev fcd cd %:p:h
