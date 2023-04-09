local M = {}

function M.feedkey(key, mode)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(key, true, true, true),
        mode,
        true
    )
end

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand '%:t') == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

-- Rename, but show edits in quickfix
-- Does not nessecarily :copen
-- After https://www.youtube.com/watch?v=tAVxxdFFYMU
function M.quick_fix_rename()
    local old = vim.fn.expand '<cword>'
    vim.ui.input({ prompt = 'New Name > ', default = old }, function(new_name)
        if #new_name <= 0 then
            return
        end
        local position_params = vim.lsp.util.make_position_params()

        position_params.newName = new_name

        vim.lsp.buf_request(
            0,
            'textDocument/rename',
            position_params,
            function(err, result, ...)
                vim.lsp.handlers['textDocument/rename'](err, result, ...)

                if not result then
                    return
                end

                local entries = {}
                if result.changes then
                    for uri, edits in pairs(result.changes) do
                        local bufnr = vim.uri_to_bufnr(uri)

                        for _, edit in ipairs(edits) do
                            local start_line = edit.range.start.line + 1
                            local line = vim.api.nvim_buf_get_lines(
                                bufnr,
                                start_line - 1,
                                start_line,
                                false
                            )[1]

                            table.insert(entries, {
                                bufnr = bufnr,
                                lnum = start_line,
                                col = edit.range.start.character + 1,
                                text = line,
                            })
                        end
                    end
                end

                vim.fn.setqflist(entries, 'r')
            end
        )
    end)
end

function M.fmt_file_name(name)
    return vim.fn.pathshorten(vim.fn.fnamemodify(name, ':~:.'), 3)
end

function M.winbar()
    local filename = vim.api.nvim_buf_get_name(0)
    local ft = vim.bo.filetype

    local ok, _ = pcall(require, 'nvim-web-devicons')
    if not ok then
        return '%=%m %f'
    end

    local char, hl =
        require('nvim-web-devicons').get_icon(filename, ft, { default = true })
    local icon = string.format('%%#%s#%s%%*', hl, char)

    return '%m '
        .. icon
        .. " %f > %{%v:lua.require'nvim-navic'.get_location()%}"
end

local winbuf = function(ty)
    return function(fn, ...)
        return vim.api['nvim_' + ty + '_' + fn](...)
    end
end
M.buf = winbuf 'buf'
M.win = winbuf 'win'

function M.yes_or_no(prompt, default, cb)
    local p
    vim.validate {
        prompt = { prompt, 's' },
        default = { default, 'b' },
        callback = { cb, 'f' },
    }
    if default then
        p = '[Y/n]'
    else
        p = '[y/N]'
    end

    vim.ui.input(
        { prompt = string.format('%s? %s ->', prompt, p) },
        function(input)
            if input == 'y' or input == 'Y' then
                cb(true)
            elseif input == 'n' or input == 'N' then
                cb(false)
            else
                cb(default)
            end
        end
    )
end

function M.pred_and(p1, p2)
    return function(input)
        return p1(input) and p2(input)
    end
end

function M.pred_or(p1, p2)
    return function(input)
        return p1(input) or p2(input)
    end
end

function M.reset_options(opts, cb)
    local old = {}
    for _, i in ipairs(opts) do
        old[i] = vim.o[i]
    end
    cb()
    for _, i in ipairs(opts) do
        vim.o[i] = old[i]
    end
end

return M
