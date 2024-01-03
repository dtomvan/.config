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
    local fd = vim.api.nvim_buf_get_option(0, 'buftype') == 'nofile' and '%y' or '%f'

    local ok, _ = pcall(require, 'nvim-web-devicons')
    if not ok then
        return '%=%m ' .. fd
    end

    local char, hl =
        require('nvim-web-devicons').get_icon(filename, nil, { default = true })
    local icon = string.format('%%#%s#%s%%*', hl, char)

    return '%m '
        .. icon
        .. ' '
        .. fd
        .. " > %{%v:lua.require'nvim-navic'.get_location()%}"
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

M.is_something_shown = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then return true end
    local listed_buffers = vim.tbl_filter(
        function(buf_id) return vim.fn.buflisted(buf_id) == 1 end,
        vim.api.nvim_list_bufs()
    )
    if #listed_buffers > 1 then return true end
    if vim.fn.argc() > 0 then return true end

    return false
end

M.source_dir = function(target)
    vim.tbl_map(function(source)
        loadfile(source)()
    end, vim.api.nvim_get_runtime_file(
        target,
        true
    ))
end

M.is_personal = function(extra)
    return vim.tbl_contains(
        vim.list_extend(
            extra or {},
            { 'tom-pc' }
        ), vim.fn.hostname())
end

for _, i in ipairs { 'buf', 'win', 'filetype' } do
    for _, j in ipairs { 'get', 'set' } do
        local f = ('%s_%s'):format(i, j)
        if f == 'filetype_set' then goto continue end
        M[f] = function(thing, opt, value)
            local c = vim.api[('nvim_%s_option_value'):format(j)]
            local params = { [i] = thing or 0 }
            if j == 'get' then
                return c(opt, params)
            else
                return c(opt, value, params)
            end
        end
        ::continue::
    end
end

M.validate_and_set_def = function(validate, subject, optional, subject_name)
    vim.validate {
        [subject_name or 'subject'] = { subject, 't', optional },
    }
    validate = vim.deepcopy(validate)
    for k, v in pairs(validate) do
        table.insert(v, 1, subject[k])
    end
    vim.validate(validate)
    for k, v in pairs(validate) do
        if not subject[k] and v[3] == true then
            subject[k] = v[4]
        end
    end
    return subject
end

local function _or_nils(t)
    local res = {}
    for k, v in pairs(t) do
        if type(v) == 'table' then
            res[k] = _or_nils(v)
        end
        res[k] = v or 'nil'
    end
    return res
end

---@param t table<string, any?>
---@return nil
M.print_nils = function(t)
    vim.print(_or_nils(t))
end

M.debug = function(...)
    local res = {}
    local args = { ... }
    for _, name in ipairs(args) do
        local value = _G[name]
        for i = 1, math.huge do
            local localname, localvalue = debug.getlocal(2, i, 1)
            if not localname then
                break
            elseif localname == name then
                value = localvalue
            end
        end
        res[name] = value or '<<nil>>'
    end
    vim.print(res)
end

return M
