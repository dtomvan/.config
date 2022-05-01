local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt

local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

require('luasnip/loaders/from_vscode').lazy_load {
    paths = { '/.local/share/nvim/site/pack/packer/start/friendly-snippets/' },
}

-- THANKS TJ
vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
]]

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    require('luasnip').jump(-1)
end, require('dtomvan.keymaps').silent)

vim.keymap.set('s', '<c-k>', function()
    require('luasnip').jump(1)
end, require('dtomvan.keymaps').silent)

ls.snippets = {
    all = {
        s(
            'time',
            f(function()
                return os.date '%H:%M:%S'
            end)
        ),
        s(
            'date',
            f(function()
                return os.date '%F'
            end)
        ),
        s(
            'datetime',
            f(function()
                return os.date '%F %T'
            end)
        ),
    },
    rust = {
        s('enum', {
            t { '#[derive(Debug, Clone, Copy)]', 'enum ' },
            i(1, 'Name'),
            t { ' {', '    ' },
            i(0),
            t { '', '}' },
        }),
        s(
            'test',
            fmt(
                [[
#[test]
fn {}() {{
    {}
}}
]],
                { i(1, { 'it_works' }), i(2) }
            )
        ),
        s(
            'modtest',
            fmt(
                [[
#[cfg(test)]
mod test {{
    use super::*;
    {}
}}
]],
                i(0)
            )
        ),
    },
    lua = {
        ls.parser.parse_snippet(
            'mf',
            [[function $1.$2($3)
    $4
end]]
        ),
    },
}
