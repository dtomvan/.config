local tbl_extend_opt = function(tbl)
    return function(desc, opts)
        return vim.tbl_extend('force', tbl, { desc = desc }, opts or {})
    end
end

local M = {}
M.silent = tbl_extend_opt { silent = true, remap = false }
M.noremap = tbl_extend_opt { noremap = true }
M.expr = tbl_extend_opt { expr = true, silent = true }
M.norexpr = tbl_extend_opt { expr = true, remap = false }
M.buffer = tbl_extend_opt { buffer = true, remap = false }

M.confusing = function(modes, k, v, opts)
    _G.confusing_maps_set = _G.confusing_maps_set or {}
    _G.confusing_maps_set[k] = { map = vim.inspect(v), desc = opts.desc }
    if type(opts.desc) == 'string' then
        opts.desc = 'confusing: ' .. opts.desc
    end
    vim.keymap.set(modes, k, function()
        if _G.confusing_maps ~= false then
            if type(v) == 'function' then
                local ok, val = pcall(v)
                return opts.expr and ok and val or ''
            else
                return v
            end
        else
            return k
        end
    end, opts)
end

local map = vim.keymap.set

-- Swap ; and :
M.confusing({ 'n', 'v' }, ';', ':', M.norexpr 'swapped with :')
M.confusing({ 'n', 'v' }, ':', ';', M.norexpr 'swapped with ;')

local breakpoints = { ',', '!', '.', '?', ';' }
for _, point in ipairs(breakpoints) do
    map(
        'i',
        point,
        point .. '<c-g>u',
        M.silent 'Set undo point when typing punctuation'
    )
end

-- Utils
--- Documentation
local function show_documentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ 'vim', 'help' }, filetype) then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
    elseif 'man' == filetype then
        vim.cmd('Man ' .. vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
        require('crates').show_popup()
    else
        vim.lsp.buf.hover()
    end
end
vim.keymap.set('n', 'K', show_documentation, { silent = true })

map('n', '<leader><CR>', '<C-w>w', M.silent 'Switch windows')
map('n', '<leader><leader>', ':<up>', M.noremap 'Last command')
map(
    'i',
    '<C-l>',
    '<c-g>u<Esc>[s1z=`]a<c-g>u',
    M.noremap "Fix last 'spell' mistake"
)

-- Window management
map('n', '<C-Down>', ':resize +2<CR>', M.silent 'Resize +2')
map('n', '<C-Up>', ':resize -2<CR>', M.silent 'Resize -2')
map(
    'n',
    '<C-Right>',
    ':vertical resize +2<CR>',
    M.silent 'Vertically resize +2'
)
map('n', '<C-Left>', ':vertical resize -2<CR>', M.silent 'Vertically resize -2')
map('n', '<C-S-Right>', '<C-w><C-L>', M.silent 'Winmove right')
map('n', '<C-S-Up>', '<C-w><C-K>', M.silent 'Winmove up')
map('n', '<C-S-Down>', '<C-w><C-J>', M.silent 'Winmove down')
map('n', '<C-S-Left>', '<C-w><C-H>', M.silent 'Winmove left')

-- Join lines correctly
M.confusing('n', 'J', 'mzJ`z', M.norexpr "Join lines 'n stay where you are")
M.confusing(
    'n',
    'gJ',
    'mzJ`z',
    M.norexpr "Join lines 'n not stay where you are"
)

-- copy entire file
map('n', '<leader>y', 'mpggyG`p', M.silent 'Copy entire buffer')
-- paste into _
map('x', '<leader>p', '"_dP', M.silent "Paste, but don't copy original text")

-- quickfix list
map('n', '<leader>j', ':cnext<CR>', M.silent 'Next quickfix entry')
map('n', '<leader>k', ':cprev<CR>', M.silent 'Prev quickfix entry')

local function nav(n)
    return function()
        require('harpoon.ui').nav_file(n)
    end
end

for i = 1, 9 do
    map(
        'n',
        ('<leader>%d'):format(i),
        nav(i),
        M.silent('Harpoon open file ' .. i)
    )
end

map('n', '<leader>m', function()
    require('harpoon.mark').add_file()
end, M.silent 'Add file to harpoon')
map('n', '<F2>', function()
    require('harpoon.ui').toggle_quick_menu()
end, M.silent 'Show harpoon UI')

map(
    'n',
    '<leader>xo',
    ':silent !chmod +x %<CR>',
    M.silent 'Make current file executable'
)

map('n', '<leader>n', ':noh<cr>', M.silent 'Disable search highlight')

map('n', '<leader>s', '<cr>so<cr>', M.silent 'Source current file')
map('n', '<leader>S', ':so ', M.noremap 'Source...')

M.confusing('n', '<up>', function()
    require('jvim').prev_sibling()
end, M.silent 'Previous sibling')
M.confusing('n', '<down>', function()
    require('jvim').next_sibling()
end, M.silent 'Next sibling')
M.confusing('n', '<left>', function()
    require('jvim').to_parent()
end, M.silent 'Goto parent')
M.confusing('n', '<right>', function()
    require('jvim').descend()
end, M.silent 'Goto child')

M.confusing('n', '~', function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1]
    local col = cursor[2]
    local char = vim.api.nvim_buf_get_text(
        0,
        row - 1,
        col,
        row - 1,
        col + 1,
        {}
    )[1] or ''
    for k, v in pairs {
        [';'] = ':',
        ['('] = ')',
        ['['] = ']',
        ['{'] = '}',
        ["'"] = '"',
        [','] = '.',
        ['`'] = '~',
        ['-'] = '_',
    } do
        if char == k then
            return 'r' .. v .. 'l'
        elseif char == v then
            return 'r' .. k .. 'l'
        end
    end
    return '~'
end, M.norexpr 'Custom change case characters')

map('v', '<leader>s', ':!sort<cr>', M.silent 'Sort visual selection')

-- Move lines
map('v', 'J', ":m '>+1<CR>gv=gv", M.silent 'Move selection down')
map('v', 'K', ":m '<-2<CR>gv=gv", M.silent 'Move selection up')
map('v', '<leader>k', ':m-2<CR>gv=gv', M.silent 'Move line up')
map('v', '<leader>j', ":m'>+<CR>gv=gv", M.silent 'Move line down')

-- TODO: Use toggleterm
-- Quick terminals
local term_win_id = 0
local function open_term(cmd, tmode, bufnr)
    local windows = vim.api.nvim_list_wins()
    for _, window_id in ipairs(windows) do
        if term_win_id == window_id then
            vim.api.nvim_win_close(term_win_id, true)
            term_win_id = 0
        end
    end
    local window = require('plenary.window.float').centered { bufnr = bufnr }
    term_win_id = window.win_id
    if bufnr == nil then
        local job = vim.fn.termopen(cmd)
        if tmode then
            vim.cmd.start()
        end
        map('n', '<esc>', function()
            require('plenary.window').try_close(window.win_id)
            vim.fn.jobstop(job)
        end, { buffer = window.bufnr })

        map({ 'n', 't' }, '<a-q>', function()
            vim.cmd.winc 'J'
        end, { buffer = window.bufnr })

        map({ 'n', 't' }, '<a-f>', function()
            open_term(cmd, tmode, window.bufnr)
        end, { buffer = window.bufnr })
    end
end

local function termbind(bind, mode, cmd, tmode, bufnr, desc)
    local is_ok, _ = pcall(map, bind, mode, function()
        open_term(cmd, tmode, bufnr)
    end, { desc = desc or ('Run ' .. cmd) })
    return is_ok
end

local function spterm(bind, mode, type)
    return pcall(
        map,
        bind,
        mode,
        string.format('<cmd>%s term://%s<cr>', type, os.getenv 'SHELL')
    )
end

spterm('n', '<leader>cv', 'vs')
spterm('n', '<leader>cx', 'sp')

local aoc
if vim.g._aoc == true then
    aoc = string.format(' -p aoc_%s %s', os.date '%Y', tonumber(os.date '%d'))
else
    aoc = ''
end

termbind('n', '<leader>cl', vim.env.SHELL, true)
termbind('n', '<leader>cb', 'mold -run cargo b', false)
termbind('n', '<leader>cc', 'mold -run cargo clippy' .. aoc, false)
termbind('n', '<leader>cr', 'mold -run cargo r' .. aoc, false)
termbind('n', '<leader>ct', 'mold -run cargo t' .. aoc, false)
termbind('n', '<leader>tl', 'mold -run cargo t --lib' .. aoc, false)

map('n', '<C-h>', '<C-w>h', M.silent 'Winmove left')
map('n', '<C-j>', '<C-w>j', M.silent 'Winmove down')
map('n', '<C-h>', '<C-w>k', M.silent 'Winmove up')
map('n', '<C-j>', '<C-w>l', M.silent 'Winmove right')
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", M.expr 'gk')
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", M.expr 'gj')

map('n', '<c-s>', function()
    local ft = vim.bo.filetype
    if ft == 'lua' or ft == 'vim' then
        return '<cmd>w<cr><cmd>so<cr>'
    else
        return ''
    end
end, M.expr 'Write and source')

map('n', 'ZZ', '<cmd>update<cr>')

map('n', '[<space>', function()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "" })
end)

map('n', ']<space>', function()
    local mark = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_lines(0, mark[1], mark[1], false, { "" })
end)

return M
