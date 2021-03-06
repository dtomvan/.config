local M = {}

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
    -- NOTE: This way is kind of naive
    local old = vim.fn.expand '<cword>'
    vim.ui.input({ prompt = 'New Name > ', default = old }, function(new_name)
        local position_params = vim.lsp.util.make_position_params()

        position_params.newName = new_name

        vim.lsp.buf_request(0, 'textDocument/rename', position_params, function(err, result, ...)
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
                        local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]

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
        end)
    end)
end

function M.file_icon(name, ext)
    local ret, _ = require('nvim-web-devicons').get_icon_color(name, ext, { default = true })
    return ret
end

function M.fmt_file_name(name)
    return vim.fn.pathshorten(vim.fn.fnamemodify(name, ':~:.'), 3)
end

function M.winbar()
    local filename = vim.api.nvim_buf_get_name(0)
    local name = M.fmt_file_name(filename)

    local ok, _ = pcall(require, 'nvim-web-devicons')
    if not ok then
        return '%=%m ' .. name
    end

    local ext_split = vim.split(filename, '.', { plain = true })
    local len = #ext_split
    local extension = ext_split[len]
    local icon = M.file_icon(filename, extension) or ''

    return '%=%m ' .. icon .. ' ' .. name
end

return M
