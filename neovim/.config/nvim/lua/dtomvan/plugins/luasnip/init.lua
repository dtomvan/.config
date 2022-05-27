local ls = require 'luasnip'
local types = require 'luasnip.util.types'

-- local c = ls.choice_node
-- local d = ls.dynamic_node

require('luasnip/loaders/from_vscode').lazy_load {
    paths = { '/.local/share/nvim/site/pack/packer/opt/friendly-snippets/' },
}

vim.cmd [[
  imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>'
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
  smap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
]]

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    require('luasnip').jump(-1)
end, require('dtomvan.keymaps').silent)

vim.keymap.set('s', '<c-k>', function()
    require('luasnip').jump(1)
end, require('dtomvan.keymaps').silent)

for _, name in ipairs { 'all', 'rust', 'lua' } do
    require('dtomvan.plugins.luasnip.' .. name)
end

ls.config.set_config {
    history = true,
    update_events = 'TextChanged,TextChangedI',
    delete_events = 'TextChanged',
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { 'choiceNode', 'Comment' } },
            },
        },
    },
    store_selection_keys = '<Tab>',
}
