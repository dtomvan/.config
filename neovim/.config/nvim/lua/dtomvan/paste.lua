local func = require 'dtomvan.utils.func'
local tables = require 'dtomvan.utils.tables'
local tbl = require 'dtomvan.utils.tables'

local url = require 'net.url'

local M = {}
---@class dtomvan.PasteHandler
---@field desc string
---@field enabled boolean
---@alias dtomvan.PasteHandlers dtomvan.PasteHandler[]
---@type dtomvan.PasteHandlers
M.handlers = {}

M.paste_handler_comp = function(lead, cmdline)
    local is_enable = vim.startswith(cmdline, 'Enable')
    local is_disable = vim.startswith(cmdline, 'Disable')
    local filtered = vim.tbl_keys(vim.tbl_filter(function(x)
        return (is_enable and not x.enabled)
            or (is_disable and x.enabled)
            or (not is_enable and not is_disable)
    end, M.handlers))
    return tbl.filter_startswith(
        tables.map_idx(filtered, vim.tbl_keys(M.handlers)),
        lead or ''
    )
end

-- WARNING: When added, paste handlers cannot be removed and can only be toggled
-- off.
M.add_paste_handler = function(name, desc, fn)
    M.handlers[name] = {
        desc = desc,
        enabled = true,
    }
    vim.paste = (function(overridden)
        return function(lines, phase)
            if not M.handlers[name].enabled then
                return overridden(lines, phase)
            end
            local ok, result = pcall(fn, lines, phase, function(...)
                return overridden(...)
            end)
            if not ok then
                vim.notify(
                    ('Failed to run paste handler `%s`: %s. Disabling...'):format(
                        name,
                        result
                    ),
                    vim.log.levels.ERROR,
                    { title = 'nvim_paste()' }
                )
                M.disable_paste_handler(name)
                return overridden(lines, phase)
            end
            return result
        end
    end)(vim.paste)
end

M.disable_paste_handler = function(name)
    if M.handlers[name] ~= nil then
        M.handlers[name].enabled = false
        return 'off'
    else
        error 'Cannot disable non-existing paste handler'
    end
end

M.enable_paste_handler = function(name)
    if M.handlers[name] ~= nil then
        M.handlers[name].enabled = true
        return 'on'
    else
        error 'Cannot enable non-existing paste handler'
    end
end

M.toggle_paste_handler = function(name)
    local h = M.handlers[name]
    if h ~= nil then
        M.handlers[name] = not h.enabled
        if h.enabled then
            return 'off'
        else
            return 'on'
        end
    else
        error 'Cannot toggle non-existing paste handler'
    end
end

for _, action in ipairs { 'disable', 'enable', 'toggle' } do
    local name = action:gsub('^%l', string.upper) .. 'PasteHandler'
    vim.api.nvim_create_user_command(name, function(o)
        local ok, err = pcall(M[action .. '_paste_handler'], o.args)
        if ok then
            vim.notify(
                ("Successfully `%s`'d paste handler `%s`. It is now %s."):format(
                    action,
                    o.args,
                    err
                )
            )
        else
            vim.notify(err)
        end
    end, {
        desc = ("`%s`'s the given paste handler"):format(action),
        nargs = 1,
        complete = M.paste_handler_comp,
    })
end

vim.api.nvim_create_user_command('PasteHandlers', function(o)
    local handlers = M.handlers
    if #o.fargs == 1 then
        handlers = vim.tbl_filter(function(x)
            return vim.startswith(x, o.args)
        end, handlers)
    end
    local res = {}
    for i, h in pairs(handlers) do
        table.insert(res, { '`' })
        table.insert(res, {
            tostring(i),
            'Function',
        })
        table.insert(res, { '`: ' })
        table.insert(res, { h.desc, 'Italic' })
        table.insert(
            res,
            h.enabled and { ' (enabled)', 'String' }
            or { ' (disabled)', 'Comment' }
        )
        table.insert(res, { '\n', 'Normal' })
    end
    vim.api.nvim_echo(res, true, {})
end, {
    desc = 'Lists all paste handlers (starting with given argument)',
    nargs = '?',
    complete = M.paste_handler_comp,
})

if vim.g.is_rwds then
    M.add_paste_handler(
        'csv_to_tsv',
        'If the pasted contents are ALL csv, then convert it to TSV.',
        function(lines, phase, cb)
            for _, i in ipairs { ',', ';' } do
                if tables.all(lines, func.set_nth(string.match, i, 2)) then
                    for j, line in ipairs(lines) do
                        lines[j] = line:gsub(i, '\t')
                    end
                    return cb(lines, phase)
                end
            end
        end
    )
end

M.add_paste_handler(
    'scrub_ansi_colors',
    'Remove ANSI escape color codes',
    function(lines, phase, cb)
        for i, line in ipairs(lines) do
            lines[i] = line:gsub('\27%[[0-9;mK]+', '')
        end
        cb(lines, phase)
    end
)

M.add_paste_handler(
    'markdown_links',
    "Convert links to a markdown inline link when it isn't one already (uses treesitter).",
    function(lines, phase, cb)
        local mode = vim.api.nvim_get_mode().mode
        if
            not (vim.o.filetype == 'markdown'
                and mode == 'i'
                and mode == 'n'
                and mode == 'niI')
        then
            return cb(lines, phase)
        end
        for i, line in ipairs(lines) do
            local j = 0
            local root

            while true do
                local s, e = string.find(line, '[a-z]+://[^ >,;]+', j + 1)
                j = e
                if j == nil then
                    break
                end

                local u = url.parse(string.sub(line, s, e)):normalize()
                if
                    u.scheme == 'http'
                    or u.scheme == 'https'
                    or u.scheme == 'ftp'
                then
                    if not root then
                        root = vim.treesitter
                            .get_string_parser(line, 'markdown_inline')
                            :parse()[1]
                            :root()
                    end
                    local node = root:named_descendant_for_range(0, s, 0, s)
                    if not node or node:type() ~= 'link_destination' then
                        local before = string.sub(line, 1, s - 1)
                        local after = string.sub(line, e + 1)
                        lines[i] = before .. ('[...](%s)'):format(u) .. after
                    end
                end
            end
        end
        cb(lines, phase)
    end
)

return M
