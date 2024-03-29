---@alias dtomvan.mini.AutoConfig boolean wether to automatically configure a
---mini module, or to use `dtomvan.config.mini.<plug>`
---if not exactly `true`, don't just require `mini.<plug>` and move on.

local utils = require 'dtomvan.utils'

local M = {}

function M.mini_req(plug, opts)
    local sp = vim.split(plug[1], '.', { plain = true })
    require('mini.' .. sp[#sp]).setup(opts)
end

---@param plug string
---@param opts {config: dtomvan.mini.AutoConfig}|table?
---@return LazySpec
function M.mini(plug, opts)
    opts = (opts or {})
    vim.validate {
        plug = { plug, 's' },
        opts = { opts, 't' },
    }
    opts = utils.validate_and_set_def({
        { 'nil', 'plugin name is specified by this helper function, not the caller!' },
        config = { 'b', true },
    }, opts)
    ---@type function
    local config
    if opts.config ~= true then
        config = M.mini_req
    end
    local opts2 = vim.deepcopy(opts)
    opts2[1] = ('echasnovski/mini.%s'):format(plug)
    return vim.tbl_deep_extend("force", opts2, {
        version = opts.version or '*',
        config = config or CONF['mini.' .. plug],
    })
end

return M
