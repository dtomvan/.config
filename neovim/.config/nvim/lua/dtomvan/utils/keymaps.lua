local tables = require 'dtomvan.utils.tables'

--- TODO: currently only buffer-local
local Keymaps = {}

function Keymaps:new(bufid)
    local res = {}
    res.id = bufid
    setmetatable(res, self)
    self.__index = self
    return res
end

function Keymaps:get(mode, lhs)
    vim.validate {
        mode = { mode, 's' },
        lhs = { lhs, 's' },
    }
    local map = vim.api.nvim_buf_get_keymap(self.id or 0, mode)
    local found = tables.peek_filter_eq(map, 'lhs', lhs)
    if #found == 0 then
        found = tables.peek_filter_startswith(map, 'lhs', lhs)
    end
    local res = {}
    for _, i in ipairs(found) do
        table.insert(res, {
            lhs = i.lhs,
            rhs = i.rhs or i.callback,
            expr = i.expr,
        })
    end
    return res
end

function Keymaps:set(mode, lhs, rhs, opts)
    vim.validate {
        mode = { mode, { 's', 't' } },
        lhs = { lhs, 's' },
        rhs = { rhs, { 's', 'f' } },
        opts = { opts, 't', true },
    }
    opts = opts or {}
    opts.buffer = self.id
    vim.keymap.set(mode, lhs, rhs, opts)
end

function Keymaps:del(mode, lhs, opts)
    vim.validate {
        mode = { mode, { 's', 't' } },
        lhs = { lhs, 's' },
        opts = { opts, 't', true },
    }
    opts = opts or {}
    opts.buffer = self.id
    vim.keymap.del(mode, lhs, opts)
end

return Keymaps
