local silent = { silent = true, noremap = true }
local noremap = { noremap = true }
local expr = { expr = true, silent = true }
local map = vim.keymap.set

R('dtomvan.tere').setup()

map('', '<space>', '<Nop>', silent)

local breakpoints = { ',', '!', '.', '?', ';' }
for _, point in ipairs(breakpoints) do
    map('i', point, point .. '<c-g>u', silent)
end

-- Utils
map('n', '<leader><CR>', '<C-w>w', silent)
map('n', '<leader><leader>', ':<up>')

-- Window management
map('n', '<C-Down>', ':resize +2<CR>', silent)
map('n', '<C-Up>', ':resize -2<CR>', silent)
map('n', '<C-Right>', ':vertical resize +2<CR>', silent)
map('n', '<C-Left>', ':vertical resize -2<CR>', silent)
map('n', '<C-S-Right>', '<C-w><C-L>', silent)
map('n', '<C-S-Up>', '<C-w><C-K>', silent)
map('n', '<C-S-Down>', '<C-w><C-J>', silent)
map('n', '<C-S-Left>', '<C-w><C-H>', silent)

-- Join lines correctly
map('n', 'J', 'mzJ`z', silent)

-- copy entire file
map('n', '<leader>y', 'mpggyG`p', silent)
-- paste into _
map('x', '<leader>p', '"_dP', silent)

-- quickfix list
map('n', '<leader>j', ':cnext<CR>', silent)
map('n', '<leader>k', ':cprev<CR>', silent)

-- harpoon
local function nav(n)
    return function()
        require('harpoon.ui').nav_file(n)
    end
end

for i in ipairs { 1, 2, 3, 4 } do
    map('n', string.format('<leader>%d', i), nav(i), silent)
end

map('n', '<leader>m', function()
    require('harpoon.mark').add_file()
end, silent)
map('n', '<F2>', function()
    require('harpoon.ui').toggle_quick_menu()
end, silent)

-- Make current file executable
map('n', '<leader>x', ':silent !chmod +x %<CR>', silent)

-- no highlight
map('n', '<leader>n', ':noh<cr>', silent)

-- shout out the file
map('n', '<leader>s', '<cr>so <cr>', silent)

map('n', '<left>', require('jvim').to_parent, silent)
map('n', '<right>', require('jvim').descend, silent)
map('n', '<up>', require('jvim').prev_sibling, silent)
map('n', '<down>', require('jvim').next_sibling, silent)

-- Sort selection
map('v', '<leader>s', ':!sort<cr>', silent)

-- Move lines
map('v', 'J', ":m '>+1<CR>gv=gv", silent)
map('v', 'K', ":m '<-2<CR>gv=gv", silent)
map('v', '<leader>k', ':m-2<CR>gv=gv', silent)
map('v', '<leader>j', ":m'>+<CR>gv=gv", silent)

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

local function termbind(bind, mode, cmd, tmode, bufnr)
    local is_ok, _ = pcall(map, bind, mode, function()
        open_term(cmd, tmode, bufnr)
    end)
    return is_ok
end

local function spterm(bind, mode, type)
    local is_ok =
        pcall(map, bind, mode, string.format('<cmd>%s term://%s<cr>', type, os.getenv 'SHELL'))
    return is_ok
end

spterm('n', '<leader>cv', 'vs')
spterm('n', '<leader>cx', 'sp')

termbind('n', '<leader>cl', vim.env.SHELL, true)
termbind('n', '<leader>cb', 'mold -run cargo b', false)
termbind('n', '<leader>cc', 'mold -run cargo clippy', false)
termbind('n', '<leader>cr', 'mold -run cargo r', false)
termbind('n', '<leader>ct', 'mold -run cargo t', false)
termbind('n', '<leader>tl', 'mold -run cargo t --lib', false)

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr)
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr)

map('n', '<c-s>', function()
    local ft = vim.bo.filetype
    if ft == 'lua' or ft == 'vim' then
        return '<cmd>w<cr><cmd>so<cr>'
    else
        return ''
    end
end, expr)

return { silent = silent, noremap = noremap, expr = expr }
