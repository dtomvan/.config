local cd = vim.fn.chdir

local winbuf = function(ty)
    return function(fn, ...)
        return vim.api['nvim_' .. ty .. '_' .. fn](...)
    end
end
local buf = winbuf 'buf'
local win = winbuf 'win'

local create_buf = vim.api.nvim_create_buf
local float = require 'plenary.window.float'

local M = {}

local default_opts = {
    key = '<space>cd',
    mode = 'n',
}

-- Main functionality
M.run = function()
    local bufnr = create_buf(false, true)
    local winnr = float.centered { bufnr = bufnr }
    local path = '.'
    vim.fn.termopen('tere', {
        on_stdout = function(_, data)
            if not data then
                return
            end
            if #data ~= 0 then
                local startpos = string.find(data[1], '/')
                if type(startpos) ~= 'number' then
                    return
                end
                path = string.sub(data[1], startpos, #data[1])
            end
        end,
        on_exit = function(_, code, _)
            if code == 0 then
                cd(vim.trim(path))
            else
                vim.notify('Error occured, not CD-ing. Code: ' .. string.format('%d', code))
            end
            win('close', winnr, true)
            buf('delete', bufnr, { force = true })
        end,
    })
    vim.cmd 'start'
end

M.setup = function(opts)
    opts = opts or {}
    opts = vim.tbl_extend('keep', opts, default_opts)

    vim.keymap.set(opts.mode, opts.key, M.run, { silent = true, desc = 'Change directory' })
end

return M
