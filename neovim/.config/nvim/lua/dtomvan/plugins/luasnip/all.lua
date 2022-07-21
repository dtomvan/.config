local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt

local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node

local function bash(_, _, command)
    local file = io.popen(command, 'r')
    local res = {}
    if file == nil then
        return ''
    end
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

ls.add_snippets('all', {
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
    s('filelist', f(bash, {}, { user_args = { 'ls' } })),
    s(
        'mit',
        fmt(
            [[Copyright {} Tom van Dijk

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]],
            { f(function()
                return os.date '%Y'
            end) }
        )
    ),
})
