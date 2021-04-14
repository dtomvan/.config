    -- _   ____________ _    ________  ___
   -- / | / / ____/ __ \ |  / /  _/  |/  /
  -- /  |/ / __/ / / / / | / // // /|_/ /
 -- / /|  / /___/ /_/ /| |/ // // /  / /
-- /_/ |_/_____/\____/ |___/___/_/  /_/
require("plugins")
require('colorbuddy').colorscheme('gruvbuddy')
require('lsp')
require('opts')
require('keymaps')
require'lspconfig'.rust_analyzer.setup {}
require'lsp_extensions'.inlay_hints {
    prefix = '',
    highlight = "Comment",
    enabled = {"TypeHint", "ChainingHint", "ParameterHint"}
}
-- Use <Tab> and <S-Tab> to navigate through popup menu
-- HOW DO I DO THIS IN LUA
vim.cmd [[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd [[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
vim.cmd [[autocmd ColorScheme * hi! link LspDiagnosticsUnderlineError SpellCap]]
vim.cmd [[autocmd ColorScheme * hi! link LspDiagnosticsUnderlineWarning SpellBad]]
vim.cmd [[autocmd ColorScheme * hi! link LspDiagnosticsUnderlineHint SpellRare]]
vim.cmd [[autocmd ColorScheme * hi! link LspDiagnosticsUnderlineInformation SpellRare]]
vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.cmd [[command B buffers]]
vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]
vim.cmd [[let mapleader = "\<Space>"]]
vim.cmd [[let g:completion_enable_auto_popup = 0]]
-- vim.cmd [[filetype plugin on]]
-- vim.cmd [[syntax enable]]
-- vim.cmd [[filetype plugin indent on]]
-- vim.cmd [[syntax on]]
vim.cmd [[let g:lightline = {'colorscheme': 'wombat'}]]
vim.cmd [[hi StatusLine guibg=#928374 guifg=#3c3836]]
