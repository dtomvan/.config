-- Open files from stdout. Run with:
-- find -type f | nvim +'luafile ~/.config/nvim/scratch/telescope-cur-buf.lua'

if MiniStarter then
    MiniStarter.config.autoopen = false
    MiniStarter.on_vimenter = function() end
end

local l = vim.api.nvim_buf_get_lines(0, 0, -1, false)

if #l < 1 or vim.api.nvim_buf_get_name(0) ~= '' then
    vim.notify('telescope-cur-buf: No input filenames, quitting', vim.log.levels.ERROR)
    return
end

vim.opt_local.bufhidden = 'hide'
vim.opt_local.buflisted = false
vim.opt_local.buftype = 'nofile'
vim.opt_local.swapfile = false
vim.api.nvim_buf_set_lines(0, 0, -1, false, {})

local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values

pickers
    .new({
        prompt_title = 'stdin files',
        finder = finders.new_table {
            results = l,
        },
        sorter = conf.file_sorter(),
    })
    :find()
