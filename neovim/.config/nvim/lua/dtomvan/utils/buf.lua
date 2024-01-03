local utils = require 'dtomvan.utils'
local func = require 'dtomvan.utils.func'
local num_domain = require 'dtomvan.utils.num_domain'
local Keymaps = require 'dtomvan.utils.keymaps'

---@alias dtomvan.BufOptions table<string, any>

---@class dtomvan.Buffer
---@field id integer buffer handle, which all of the buffer data stems from
---@field bo dtomvan.BufOptions all of the buffer-local resolved options which correspond to the buffer's `id`
---@field marks dtomvan.BufOptions all buffer-local marks
---@field keymaps dtomvan.BufOptions all keymaps that apply to this buffer, including the non-overridden global ones
local Buffer = {}

local M = {}

for _, i in ipairs { 'get', 'set' } do
    M['option_' .. i] = function(id, key, value)
        return utils['buf_' .. i](id, key, value)
    end
end

M.mark_get = function(id, key)
    return vim.api.nvim_buf_get_mark(id, key)
end
M.mark_set = function(id, key, new_value)
    utils.validate_and_set_def({
        { num_domain.natural,     'natural number',       1 },
        { num_domain.zeroindexed, 'whole number, not <0', 0 },
    }, new_value, 'new_value', false)
    return vim.api.nvim_buf_set_mark(id, key, new_value[1], new_value[2], {})
end

function Buffer:getset(type)
    return setmetatable({}, {
        __index = func.replace_first(M[type .. '_get'], self.id),
        __newindex = func.replace_first(M[type .. '_set'], self.id),
    })
end

function Buffer:exists(id)
    return vim.fn.bufexists(id or self.id) == 1
end

function Buffer:require_exists(id, because)
    if type(because) == 'string' then
        because = '. This is required because ' .. because
    end
    if not self:exists(id) then
        error(("while opening a buffer handle: buffer %d does not exist anymore or yet%s"):format(id or self.id), because)
    end
end

function Buffer:loaded(id)
    return vim.api.nvim_buf_is_loaded(id or self.id)
end

function Buffer:require_loaded(id)
    if not self:loaded(id) then
        error(("buffer %d is required to be loaded but isn't"):format(id or self.id))
    end
end

function Buffer:open(id)
    vim.validate { id = { id, 'n' } }
    local function ide(e)
        error(("while opening a buffer handle: `id` must be %s. Got: %s"):format(e, id))
    end
    if not num_domain.nonzero(id) then
        ide 'nonzero'
    end
    if not num_domain.natural(id) then
        ide 'a natural number'
    end
    self:require_exists(id)
    local buf = {}
    ---@cast buf dtomvan.Buffer
    setmetatable(buf, self)
    self.__index = self

    buf.id = id
    buf.bo = buf:getset 'option'
    buf.marks = buf:getset 'mark'
    buf.keymaps = Keymaps:new(id)
    return buf
end

function Buffer:from_bufnr(bufnr, create)
    vim.validate {
        bufnr = { bufnr, { 'nil', 'n', 's' } },
        create = { create, 'b', true },
    }
    return self:open(vim.fn.bufnr(bufnr, create or false))
end

function Buffer:current()
    return vim.api.nvim_get_current_buf()
end

function Buffer:from_current()
    return self:open(self:current())
end

---@class dtomvan.BufCreateOpts
---@field listed boolean? sets 'buflisted'
---@field scratch boolean? see :h scratch-buffer
---@field options dtomvan.BufOptions? which options to set after creation
local function make_create_opts(o)
    o = o or {}
    return utils.validate_and_set_def({
        listed = { 'b', true, true },
        scratch = { 'b', true, false },
        options = { 't', true, {} }
    }, o)
end

---@param opts dtomvan.BufCreateOpts?
---@return dtomvan.Buffer
function Buffer:create(opts)
    opts = make_create_opts(opts)
    local handle = vim.api.nvim_create_buf(opts.listed, opts.scratch)
    for k, v in pairs(opts.options) do
        utils.buf_set(handle, k, v)
    end
    local ok, ret = pcall(self.open, self, handle)
    if not ok then
        error(('couldn\'t refer to buffer by id %d. Caused by: %s'):format(handle, ret))
    end
    return ret
end

function Buffer:list(require_loaded)
    vim.validate {
        require_loaded = { require_loaded, 'b', true }
    }
    local iter = vim.iter(vim.api.nvim_list_bufs())
    if require_loaded then
        iter = iter:filter(function(x) return self:loaded(x) end)
    end
    return iter:map(function(x) return self:open(x) end)
end

function Buffer:name()
    self:require_exists(nil, 'tried to get the name for the buffer')
    return vim.api.nvim_buf_get_name(self.id)
end

for _, i in ipairs { 'delete', 'wipeout' } do
    Buffer[i] = function(self, force)
        self:require_exists()
        local command = 'b' .. i
        if force then
            command = command .. '!'
        end
        vim.cmd[command](self.id)
    end
end

function Buffer:goto()
    vim.cmd.b(self.id)
end

return Buffer
