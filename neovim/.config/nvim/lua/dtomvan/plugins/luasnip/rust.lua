local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

ls.add_snippets('rust', {
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
})
