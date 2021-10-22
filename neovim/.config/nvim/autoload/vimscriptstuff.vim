hi TabLineFill guibg=#333333
let mapleader = "\<Space>"
hi StatusLine guibg=#928374 guifg=#3c3836
set clipboard=unnamedplus
command! -nargs=* Ca !cargo <args>
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
autocmd BufEnter *.rs nnoremap J :lua require'rust-tools.join_lines'.join_lines()<CR>
autocmd BufEnter *.mom set ft=mom
cnoreabbrev luf luafile
cnoreabbrev fcd cd %:p:h
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
let g:coq_settings = { 'auto_start': 'shut-up', 'keymap.recommended': v:true, 'keymap.jump_to_mark': '<c-j>' }

nnoremap <silent> <M-p> :call TransposeWords()<cr>

" move line(s) up/down
nnoremap <silent> <leader>k :m-2<CR>==
nnoremap <silent> <leader>j :m+<CR>==
vnoremap <silent> <leader>k :m-2<CR>gv=gv
vnoremap <silent> <leader>j :m'>+<CR>gv=gv
function! OnUIEnter(event)
    let l:ui = nvim_get_chan_info(a:event.chan)
    if has_key(l:ui, 'client') && has_key(l:ui.client, 'name')
        if l:ui.client.name ==# 'Firenvim'
            set guifont=monospace:h10
            let fc = g:firenvim_config['localSettings']
            let fc['https?://twitter.com/'] = { 'takeover': 'never', 'priority': 1 }
            let fc['https?://twitch.tv/'] = { 'takeover': 'never', 'priority': 1 }
        endif
    endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
