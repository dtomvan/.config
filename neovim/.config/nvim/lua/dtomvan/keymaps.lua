local silent = { silent = true, noremap = true }
local noremap = { noremap = true }
local expr = { expr = true, silent = true }

vim.keymap.set('', '<space>', '<Nop>', silent)

-- Thanks prime (:
local breakpoints = { ',', '!', '.', '?', ';' }
for _, point in ipairs(breakpoints) do
    vim.keymap.set('i', point, point .. '<c-g>u', silent)
end

-- Toggles
vim.keymap.set('n', '<leader>ot', '<cmd>set expandtab!<cr><cmd>set expandtab?<cr>', silent)

-- Utils
vim.keymap.set('n', '<leader><CR>', '<C-w>w', silent)
vim.keymap.set('n', '<leader><leader>', ':<up>', silent)
vim.keymap.set('n', '<leader>id', "<cmd>r !date +'%F'<CR>", silent)

-- Window management
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', silent)
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', silent)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', silent)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', silent)
vim.keymap.set('n', '<C-S-Right>', '<C-w><C-L>', silent)
vim.keymap.set('n', '<C-S-Up>', '<C-w><C-K>', silent)
vim.keymap.set('n', '<C-S-Down>', '<C-w><C-J>', silent)
vim.keymap.set('n', '<C-S-Left>', '<C-w><C-H>', silent)

-- Join lines correctly
vim.keymap.set('n', 'J', 'mzJ`z', silent)
-- copy entire file
vim.keymap.set('n', '<leader>y', 'mpggyG`p', silent)
-- quickfix list
vim.keymap.set('n', '<leader>j', ':cnext<CR>', silent)
vim.keymap.set('n', '<leader>k', ':cprev<CR>', silent)
-- harpoon
vim.keymap.set('n', '\\a', function()
    require('harpoon.mark').add_file()
end, silent)
vim.keymap.set('n', '<F1>', function()
    require('harpoon.ui').toggle_quick_menu()
end, silent)
vim.keymap.set('n', '<F2>', function()
    require('harpoon.ui').nav_file(1)
end, silent)
vim.keymap.set('n', '<F3>', function()
    require('harpoon.ui').nav_file(2)
end, silent)
vim.keymap.set('n', '<C-y>', function()
    require('harpoon.ui').nav_file(3)
end, silent)
vim.keymap.set('n', '<C-\\>', function()
    require('harpoon.ui').nav_file(4)
end, silent)
-- chmod +x
vim.keymap.set('n', '<leader>x', ':silent !chmod +x %<CR>', silent)
-- no highlight
vim.keymap.set('n', '<leader>n', ':noh<cr>', silent)
-- shout out the file
vim.keymap.set('n', '<leader>s', ':so %<cr>', silent)
-- paste correctly
vim.keymap.set('n', 'p', 'p==', silent)

-- DA PRIMAGEN
vim.keymap.set('n', '<left>', require('jvim').to_parent, silent)
vim.keymap.set('n', '<right>', require('jvim').descend, silent)
vim.keymap.set('n', '<up>', require('jvim').prev_sibling, silent)
vim.keymap.set('n', '<down>', require('jvim').next_sibling, silent)

-- Sort selection
vim.keymap.set('v', '<leader>s', ':!sort<cr>', silent)
-- Move lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", silent)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", silent)
-- Never used this prob does the same
vim.keymap.set('v', '<leader>k', ':m-2<CR>gv=gv', silent)
vim.keymap.set('v', '<leader>j', ":m'>+<CR>gv=gv", silent)

-----------------------------------------
-- Lua bindings (neovim 0.7 or higher) --
-----------------------------------------

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
            vim.cmd 'start'
        end
        vim.keymap.set('n', '<esc>', function()
            require('plenary.window').try_close(window.win_id)
            vim.fn.jobstop(job)
        end, { buffer = window.bufnr })

        vim.keymap.set({ 'n', 't' }, '<a-q>', function()
            vim.cmd 'winc J'
        end, { buffer = window.bufnr })

        vim.keymap.set({ 'n', 't' }, '<a-f>', function()
            open_term(cmd, tmode, window.bufnr)
        end, { buffer = window.bufnr })
    end
    vim.cmd 'autocmd! WinLeave <buffer>'
end
vim.keymap.set('n', '<leader>cl', function()
    open_term(vim.env.SHELL, true)
end)
vim.keymap.set('n', '<leader>cb', function()
    open_term('mold -run cargo b', false)
end)
vim.keymap.set('n', '<leader>cc', function()
    open_term('mold -run cargo clippy', false)
end)
vim.keymap.set('n', '<leader>cr', function()
    open_term('mold -run cargo r', false)
end)
vim.keymap.set('n', '<leader>ct', function()
    open_term('mold -run cargo t', false)
end)
vim.keymap.set('n', '<leader>tl', function()
    open_term('mold -run cargo t --lib', false)
end)

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- neorg
vim.keymap.set('n', '<leader>no', '<cmd>tabnew<cr>:Neorg workspace <tab>', { remap = true })

return { silent = silent, noremap = noremap, expr = expr }
