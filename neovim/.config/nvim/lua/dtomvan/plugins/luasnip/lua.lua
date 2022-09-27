local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt

local f = ls.function_node
local i = ls.insert_node
local c = ls.choice_node
local s = ls.snippet

ls.add_snippets('lua', {
    s(
        'req',
        fmt([[local {} = require '{}']], {
            c(2, {
                f(function(name)
                    local split = vim.split(name[1][1], '.', true)
                    return split[#split] or ''
                end, { 1 }),
                i(1),
            }),
            i(1),
        })
    ),
})
