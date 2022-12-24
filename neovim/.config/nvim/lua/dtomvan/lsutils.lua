local ls = require 'luasnip'
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local sn = ls.snippet_node
local t = ls.text_node

local M = {}

M.bash = function(_, _, command)
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

M.lenrep = function(args, _, char)
    return string.rep(char or '─', #args[1][1] + 2)
end

M.indent = function(_, _, _)
    return string.rep(' ', vim.bo.tabstop)
end

M.ri = function(insert_node_id)
    return f(function(args)
        return args[1][1]
    end, insert_node_id)
end

M.make_rec = function(prefix, postfix)
    prefix = prefix or ''
    postfix = postfix or ''
    local snip
    snip = function()
        return sn(
            nil,
            c(1, {
                -- Order is important, sn(...) first would cause infinite loop of expansion.
                t '',
                sn(nil, { t { '', prefix }, i(1), t(postfix), d(2, snip, {}) }),
            })
        )
    end
    return snip
end

return M
