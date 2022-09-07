local builtin = require 'el.builtin'
local extensions = require 'el.extensions'
local sections = require 'el.sections'
local subscribe = require 'el.subscribe'
local utils = require 'dtomvan.utils'

local function icon(_, buf)
    return utils.file_icon(buf.name, buf.extension)
end

local mode_wrapper = function(win, buf)
    if win.is_active then
        return extensions.mode(win, buf)
    else
        return ''
    end
end

local relative_file_name = function(_, buf)
    return utils.fmt_file_name(buf.name)
end

local generator = function(win)
    local segs = {}

    if win.is_active then
        table.insert(segs, mode_wrapper)
    end

    table.insert(segs, sections.split)
    local ok, mod = pcall(require, 'nvim-web-devicons')
    if ok and mod.has_loaded() == true then
        table.insert(segs, subscribe.buf_autocmd('el_file_icon', 'BufRead', icon))
    end
    table.insert(segs, ' ')
    table.insert(segs, relative_file_name)
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
                    return ' ' .. branch
                end
            end)
        )
    end

    return segs
end

-- And then when you're all done, just call
require('el').setup { generator = generator }
