local overseer = require 'overseer'
local keymaps = require 'dtomvan.keymaps'
local sidebar = require 'overseer.task_list.sidebar'

vim.keymap.set(
    'n',
    'a',
    '<cmd>OverseerRun<cr>',
    keymaps.silent('Run...', { buffer = true })
)

local function action(ac)
    return function()
        local sb = sidebar.get_or_create()
        local lnum = vim.api.nvim_buf_get_mark(0, '.')[1]
        local task = sb:_get_task_from_line(lnum)

        overseer.run_action(task, ac)
    end
end


vim.keymap.set(
    'n',
    'd',
    action 'dispose',
    keymaps.silent('Dispose current task', { buffer = true })
)
