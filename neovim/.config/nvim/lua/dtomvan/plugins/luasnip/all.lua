local ls = require 'luasnip'
local s = ls.snippet
local f = ls.function_node

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
})
