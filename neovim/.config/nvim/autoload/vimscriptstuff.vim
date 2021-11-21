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
nno <silent> <leader>k :m-2<CR>==
nno <silent> <leader>j :m+<CR>==
vno <silent> <leader>k :m-2<CR>gv=gv
vno <silent> <leader>j :m'>+<CR>gv=gv
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

nno J mzJ`z
nno <silent> <leader>j :cnext<CR>zz
nno <silent> <leader>k :cprev<CR>zz
" nnoremap <silent> <leader>j :lnext<CR>zz
" nnoremap <silent> <leader>k :lprev<CR>zz
nno <silent> \a :lua require("harpoon.mark").add_file()<CR>
nno <silent> <F1> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nno <silent> <C-Space> :lua require("harpoon.ui").nav_file(1)<CR>
nno <silent> <C-c> :lua require("harpoon.ui").nav_file(2)<CR>
nno <silent> <C-y> :lua require("harpoon.ui").nav_file(3)<CR>
nno <silent> <C-h> :lua require("harpoon.ui").nav_file(4)<CR>
nno <leader>x :silent !chmod +x %<CR>
nno <silent> <leader>n :noh<cr>
nno <leader>s :so %<cr>
vno <leader>s :!sort<cr>

vno <silent> J :m '>+1<CR>gv=gv
vno <silent> K :m '<-2<CR>gv=gv

nno Y yg$
nno n nzzzv
nno N Nzzzv
nno J mzJ`z
nno { {zzzv
nno } }zzzv
autocmd BufEnter *.hs nnoremap <leader>sb :!stack build<cr>
nno j gjzzzv
nno k gkzzzv
vno j jzzzv
vno k kzzzv
nno p p==
