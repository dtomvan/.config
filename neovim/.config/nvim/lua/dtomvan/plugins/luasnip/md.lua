local ls = require 'luasnip'
local s = ls.snippet
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets('markdown', {
    s('line', {
        t { '- **' },
        c (1, { t 'Maya', t 'Tom', t 'Tim', i(1) }),
        t { '**: "' },
        i(2),
        t { '"', '' },
    }),
})
