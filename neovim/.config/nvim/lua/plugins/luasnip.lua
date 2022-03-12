local ls = require 'luasnip'

vim.o.runtimepath = vim.o.runtimepath
    .. ','
    .. os.getenv 'HOME'
    .. '/.local/share/nvim/site/pack/packer/start/friendly-snippets/'
require('luasnip/loaders/from_vscode').load()

-- THANKS TJ
vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
]]

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    require('luasnip').jump(-1)
end, require('keymaps').silent)

vim.keymap.set('s', '<c-k>', function()
    require('luasnip').jump(1)
end, require('keymaps').silent)

ls.snippets = {
    lua = {
        ls.parser.parse_snippet(
            'mf',
            [[function $1.$2($3)
    $4
end]]
        ),
    },
}
