local utils = require 'dtomvan.lsutils'

return {
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
    s('filelist', f(utils.bash, {}, { user_args = { 'ls' } })),
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
            {
                c(1, {
                    f(function()
                        return os.date '%Y'
                    end),
                    i(nil, 'Custom year here'),
                }),
            }
        )
    ),
    s(
        'box',
        fmt(
            '┌{}┐\n| {} |\n└{}┘',
            { f(utils.lenrep, { 1 }), i(1), f(utils.lenrep, { 1 }) }
        )
    ),
    s('bang', {
        t '#!/usr/bin/env ',
        c(1, {
            t 'sh',
            t 'zsh',
            t 'bash',
            t 'python',
            t 'node',
        }),
        i(0),
    }),
}, { key = 'all' }
