local builtin = require 'el.builtin'
local extensions = require 'el.extensions'
local sections = require 'el.sections'
local subscribe = require 'el.subscribe'

local mode_wrapper = function(win, buf)
    if win.is_active then
        return extensions.mode(win, buf)
    else
        return ''
    end
end

local generator = function(win)
    local segs = {}

    if win.is_active then
        table.insert(segs, mode_wrapper)
    end

    table.insert(segs, '%#Normal#')
    table.insert(segs, sections.split)

    if win.is_active then
        table.insert(segs, '[')
        table.insert(segs, builtin.line)
        table.insert(segs, ':')
        table.insert(segs, builtin.column)
        table.insert(segs, ']')

        table.insert(
            segs,
            sections.collapse_builtin {
                '[',
                builtin.help_list,
                builtin.readonly_list,
                ']',
            }
        )

        table.insert(
            segs,
            subscribe.buf_autocmd('el_git_branch', 'BufEnter', function(window, buffer)
                local branch = extensions.git_branch(window, buffer)
                if branch then
                    return '  ' .. branch
                end
            end)
        )
    end
    table.insert(segs, '%*')

    return segs
end

require('el').setup { generator = generator }
