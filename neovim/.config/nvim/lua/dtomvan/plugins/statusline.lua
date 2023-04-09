local utils = require 'dtomvan.utils'

local function bufline_generator(win, buf)
    local cur = vim.api.nvim_get_current_buf()

    local segs = {}
    local bufs = vim.tbl_filter(
        utils.pred_and(
            vim.api.nvim_buf_is_loaded,
            function(i)
                return vim.api.nvim_buf_get_option(i, 'bl') == true
            end
        ),
        vim.api.nvim_list_bufs()
    )
    for i, b in ipairs(bufs) do
        local name = vim.api.nvim_buf_get_name(b)
        if #name == 0 then
            name = '[*]'
        end
        if i > 1 then
            table.insert(segs, ' | ')
        end
        local char, hl =
            require('nvim-web-devicons').get_icon(
                name,
                vim.api.nvim_buf_get_option(b, 'ft'),
                { default = true }
            )
        local icon = string.format('%%#%s#%s%%*', hl, char)
        table.insert(segs, icon .. ' ')
        if cur == b then
            table.insert(segs, '%#Bold#')
        end
        table.insert(segs, vim.fn.fnamemodify(name, ':t'))

        if cur == b then
            table.insert(segs, '%#Normal#')
        end
    end
    return table.concat(segs, '')
end

local M = {
    'tjdevries/express_line.nvim',
    event = 'UIEnter',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
}

M.config = function()
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

    local generator = function(win, buf)
        if buf.filetype == 'starter' then
            return {}
        end

        local segs = {}

        if win.is_active then
            table.insert(segs, mode_wrapper)
        end

        table.insert(segs, '%#Normal#')
        table.insert(segs, sections.split)

        if win.is_active then
            table.insert(segs, bufline_generator)
        end

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
                subscribe.buf_autocmd(
                    'el_git_branch',
                    'BufEnter',
                    function(window, buffer)
                        local branch = extensions.git_branch(window, buffer)
                        if branch then
                            return '  ' .. branch
                        end
                    end
                )
            )
        end
        table.insert(segs, '%*')

        return segs
    end

    require('el').setup { generator = generator }
end

return M
