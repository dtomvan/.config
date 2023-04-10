local formatter = require 'dtomvan.formatter'

local function flip(map, opt, t, f, tbl, src_func, dest_func)
    return {
        map,
        function()
            if type(src_func) ~= 'function' then
                return flip(map, opt, t, f, tbl, function(key)
                    return (tbl or vim.o)[key]
                end)
            end
            if type(dest_func) ~= 'function' then
                return flip(map, opt, t, f, tbl, src_func, function(res)
                    (tbl or vim.o)[opt] = res
                end)
            end

            local t1 = t or true
            if src_func(opt) == t1 then
                dest_func(f or false)
            else
                dest_func(t1)
            end
        end,
        { desc = opt },
    }
end

local function toggles(t, comp, tbl)
    local ret = {}
    for _, i in ipairs(t) do
        ret[i] = function()
            if (tbl or vim.o)[i] == (comp or true) then
                return '[x]'
            else
                return '[ ]'
            end
        end
    end
    return ret
end

local hint = [[
  ^ ^        Options
  ^
  _C_ %{conceallevel} conceal
  _c_ %{cul} cursorline
  _f_ %{fos} format-on-save
  _F_ %{global_on_save_enabled} global format-on-save
  _i_ %{list} listchars
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _s_ %{spell} spell
  _t_ %{et} expand tab
  _T_ %{title} title
  _v_ %{ve} virtual block
  _w_ %{wrap} wrap
  ^
       ^^^^                _<Esc>_
]]

return {
    name = 'Options',
    hint = hint,
    config = {
        color = 'amaranth',
        invoke_on_body = true,
        hint = {
            border = 'rounded',
            position = 'middle',
            funcs = vim.tbl_extend(
                'force',
                toggles { 'et', 'title' },
                toggles({ 'conceallevel' }, 2),
                {
                    fos = function()
                        if formatter.do_format_on_save(vim.api.nvim_get_current_buf()) then
                            return '[X]'
                        else
                            return '[ ]'
                        end
                    end
                },
                toggles({ 'global_on_save_enabled' }, nil, formatter)
            ),
        },
    },
    mode = { 'n', 'x' },
    body = '<leader>o',
    heads = {
        flip('C', 'conceallevel', 2, 0),
        flip('c', 'cursorline'),
        flip('f', nil, nil, nil, nil, function()
        end, function() formatter.toggle_fmt_on_save(vim.api.nvim_get_current_buf()) end),
        flip('F', 'global_on_save_enabled', nil, nil, formatter),
        flip('i', 'list'),
        flip('n', 'number'),
        flip('r', 'relativenumber'),
        flip('s', 'spell'),
        flip('t', 'expandtab'),
        flip('T', 'title'),
        flip('v', 'virtualedit', 'all', 'block'),
        flip('w', 'wrap'),
        { '<Esc>', nil, { exit = true } },
    },
}
