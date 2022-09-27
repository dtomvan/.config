local wk = require 'which-key'
local tbl_extend_opt = function(tbl)
    return function(desc)
        return vim.tbl_extend('keep', tbl, { desc = desc })
    end
end

local M = {}
M.silent = tbl_extend_opt { silent = true, noremap = true }
M.noremap = tbl_extend_opt { noremap = true }
M.expr = tbl_extend_opt { expr = true, silent = true }
local map = vim.keymap.set

R('dtomvan.tere').setup()

local breakpoints = { ',', '!', '.', '?', ';' }
for _, point in ipairs(breakpoints) do
    map('i', point, point .. '<c-g>u', M.silent 'Set undo point when typing punctuation')
end

-- Utils
map('n', '<leader><CR>', '<C-w>w', M.silent 'Switch windows')
map('n', '<leader><leader>', ':<up>', M.noremap 'Last command')

-- Window management
map('n', '<C-Down>', ':resize +2<CR>', M.silent 'Resize +2')
map('n', '<C-Up>', ':resize -2<CR>', M.silent 'Resize -2')
map('n', '<C-Right>', ':vertical resize +2<CR>', M.silent 'Vertically resize +2')
map('n', '<C-Left>', ':vertical resize -2<CR>', M.silent 'Vertically resize -2')
map('n', '<C-S-Right>', '<C-w><C-L>', M.silent 'Winmove right')
map('n', '<C-S-Up>', '<C-w><C-K>', M.silent 'Winmove up')
map('n', '<C-S-Down>', '<C-w><C-J>', M.silent 'Winmove down')
map('n', '<C-S-Left>', '<C-w><C-H>', M.silent 'Winmove left')

-- Join lines correctly
map('n', 'J', 'mzJ`z', M.silent "Join lines 'n stay where you are")
map('n', 'gJ', 'mzJ`z', M.silent "Join lines 'n not stay where you are")

-- copy entire file
map('n', '<leader>y', 'mpggyG`p', M.silent 'Copy entire buffer')
-- paste into _
map('x', '<leader>p', '"_dP', M.silent "Paste, but don't copy original text")

-- quickfix list
map('n', '<leader>j', ':cnext<CR>', M.silent 'Next quickfix entry')
map('n', '<leader>k', ':cprev<CR>', M.silent 'Prev quickfix entry')

-- harpoon
local function nav(n)
    return function()
        require('harpoon.ui').nav_file(n)
    end
end

for i in ipairs { 1, 2, 3, 4 } do
    map('n', string.format('<leader>%d', i), nav(i), M.silent('Harpoon open file ' .. i))
end

map('n', '<leader>m', function()
    require('harpoon.mark').add_file()
end, M.silent 'Add file to harpoon')
map('n', '<F2>', function()
    require('harpoon.ui').toggle_quick_menu()
end, M.silent 'Show harpoon UI')

map('n', '<leader>x', ':silent !chmod +x %<CR>', M.silent 'Make current file executable')

map('n', '<leader>n', ':noh<cr>', M.silent 'Disable search highlight')

map('n', '<leader>s', '<cr>so<cr>', M.silent 'Source current file')
map('n', '<leader>S', ':so ', M.noremap 'Source...')

map('n', '<left>', require('jvim').to_parent, M.silent 'Goto parent')
map('n', '<right>', require('jvim').descend, M.silent 'Goto child')
map('n', '<up>', require('jvim').prev_sibling, M.silent 'Previous sibling')
map('n', '<down>', require('jvim').next_sibling, M.silent 'Next sibling')

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
            EX.start()
        end
        map('n', '<esc>', function()
            require('plenary.window').try_close(window.win_id)
            vim.fn.jobstop(job)
        end, { buffer = window.bufnr })

        map({ 'n', 't' }, '<a-q>', function()
            EX.winc 'J'
        end, { buffer = window.bufnr })

        map({ 'n', 't' }, '<a-f>', function()
            open_term(cmd, tmode, window.bufnr)
        end, { buffer = window.bufnr })
    end
    EX['autocmd!']('WinLeave', '<buffer>')
end

local function termbind(bind, mode, cmd, tmode, bufnr, desc)
    local is_ok, _ = pcall(map, bind, mode, function()
        open_term(cmd, tmode, bufnr)
    end, { desc = desc or ('Run ' .. cmd) })
    return is_ok
end

local function spterm(bind, mode, type)
    return pcall(map, bind, mode, string.format('<cmd>%s term://%s<cr>', type, os.getenv 'SHELL'))
end

spterm('n', '<leader>cv', 'vs')
spterm('n', '<leader>cx', 'sp')

termbind('n', '<leader>cl', vim.env.SHELL, true)
termbind('n', '<leader>cb', 'mold -run cargo b', false)
termbind('n', '<leader>cc', 'mold -run cargo clippy', false)
termbind('n', '<leader>cr', 'mold -run cargo r', false)
termbind('n', '<leader>ct', 'mold -run cargo t', false)
termbind('n', '<leader>tl', 'mold -run cargo t --lib', false)

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

wk.register({
    c = { name = 'Terminal' },
    d = { name = 'Dot' },
    f = { name = 'Find' },
    g = { name = 'Goto', f = 'File' },
    r = { name = 'Re...' },
    t = { name = 'Transpose/Term' },
    w = { name = 'LSP Workspace' },
}, { prefix = '<leader>' })

return M
