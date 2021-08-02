inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
hi TabLineFill guibg=#333333
let mapleader = "\<Space>"
hi StatusLine guibg=#928374 guifg=#3c3836
set clipboard=unnamedplus
command! -nargs=* Ca !cargo <args>
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
autocmd BufEnter *.rs nnoremap J :lua require'rust-tools.join_lines'.join_lines()<CR>
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
call wilder#set_option('modes', ['/', '?', ':'])
call wilder#set_option('renderer', wilder#popupmenu_renderer(
            \ { 'highlighter': [ wilder#lua_fzy_highlighter(), ], }))
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': ['fd', '-tf', '--hidden', "-E", ".git"],
      \       'dir_command': ['fd', '-td', '--hidden', "-E", ".git"],
      \       'filters': ['cpsm_filter'],
      \     }),
      \     wilder#cmdline_pipeline(),
      \     wilder#python_search_pipeline(),
      \   ),
      \ ])
cnoreabbrev luf luafile
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
