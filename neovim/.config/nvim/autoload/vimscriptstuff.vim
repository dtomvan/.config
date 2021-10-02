" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
hi TabLineFill guibg=#333333
let mapleader = "\<Space>"
hi StatusLine guibg=#928374 guifg=#3c3836
set clipboard=unnamedplus
command! -nargs=* Ca !cargo <args>
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
autocmd BufEnter *.rs nnoremap J :lua require'rust-tools.join_lines'.join_lines()<CR>
autocmd BufEnter *.mom set ft=mom
" call wilder#enable_cmdline_enter()
" set wildcharm=<Tab>
" cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
" cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
" call wilder#set_option('modes', ['/', '?', ':'])
" call wilder#set_option('renderer', wilder#popupmenu_renderer(
"             \ { 'highlighter': [ wilder#lua_fzy_highlighter(), ], }))
" call wilder#set_option('pipeline', [
"       \   wilder#branch(
"       \     wilder#python_file_finder_pipeline({
"       \       'file_command': ['fd', '-tf', '--hidden', "-E", ".git"],
"       \       'dir_command': ['fd', '-td', '--hidden', "-E", ".git"],
"       \       'filters': ['cpsm_filter'],
"       \     }),
"       \     wilder#cmdline_pipeline(),
"       \     wilder#python_search_pipeline(),
"       \   ),
"       \ ])
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
" ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
" ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
" ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
" ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
" ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
" Expand or jump
" imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
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
