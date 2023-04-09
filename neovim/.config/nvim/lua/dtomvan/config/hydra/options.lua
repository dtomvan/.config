local function flip(map, opt)
    return {
        map,
        function()
            vim.o[opt] = not vim.o[opt]
        end,
        { desc = opt },
    }
end

local function toggles(t, comp)
    local ret = {}
    for _, i in ipairs(t) do
        ret[i] = function()
            if vim.o[i] == (comp or true) then
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
                toggles({ 'conceallevel' }, 2)
            ),
        },
    },
    mode = { 'n', 'x' },
    body = '<leader>o',
    heads = {
        flip('n', 'number'),
        flip('r', 'relativenumber'),
        {
            'v',
            function()
                if vim.o.virtualedit == 'all' then
                    vim.o.virtualedit = 'block'
                else
                    vim.o.virtualedit = 'all'
                end
            end,
            { desc = 'virtualedit' },
        },
        flip('i', 'list'),
        flip('s', 'spell'),
        flip('w', 'wrap'),
        flip('c', 'cursorline'),
        flip('t', 'expandtab'),
        flip('T', 'title'),
        {
            'C',
            function()
                if vim.o.conceallevel ~= 2 then
                    vim.o.conceallevel = 2
                else
                    vim.o.conceallevel = 0
                end
            end,
            { desc = 'conceallevel' },
        },
        { '<Esc>', nil, { exit = true } },
    },
}
