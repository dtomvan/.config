local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local c = ls.choice_node

local function ok_if_result(index)
    return f(function(arg)
        if arg[1][1]:match 'Result' then
            return 'Ok(())'
        else
            return ''
        end
    end, { index })
end

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
    s(
        'main',
        fmta(
            [[fn main() <>{
    <>
    <>
}]],
            {
                c(1, {
                    t '',
                    t '-> std::result::Result<(), Box<dyn std::error::Error>>',
                    t '-> Result<()>',
                }),
                i(2),
                ok_if_result(1),
            }
        )
    ),
})
