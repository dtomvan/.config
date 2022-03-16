local builtin = require 'el.builtin'
local extensions = require 'el.extensions'
local sections = require 'el.sections'
local subscribe = require 'el.subscribe'

local function icon(_, buf)
    local filename = buf.name
    local extension = buf.extension
    local icon_str, _ = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    return icon_str
end

local lsp_current_status = function(win, _)
    local status = require('lsp-status').status()
    if type(status) == 'string' then
        if win.is_active then
            -- Hacky way to get rid of extra characters from
            -- rust_analyzer
            local result, _ = string.gsub(status, '\240\159\135\187', '')
            return result
        end
    else
        return ' '
    end
end

local mode_wrapper = function(win, buf)
    if win.is_active then
        return extensions.mode(win, buf)
    else
        return ''
    end
end

local relative_file_name = function(_, buf)
    return vim.fn.pathshorten(vim.fn.fnamemodify(buf.name, ':~:.'), 3)
end

local generator = function(win)
    local segs = {}

    if win.is_active then
        table.insert(segs, mode_wrapper)
    end

    table.insert(segs, sections.split)
    table.insert(segs, subscribe.buf_autocmd('el_file_icon', 'BufRead', icon))
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
        table.insert(segs, builtin.quickfix)

        table.insert(segs, lsp_current_status)
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
