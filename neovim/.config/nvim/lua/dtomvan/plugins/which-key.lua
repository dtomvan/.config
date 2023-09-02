local tables = require 'dtomvan.utils.tables'

local leader_key = { '<leader>', {
    c = 'Terminal',
    d = 'Dot',
    f = 'Find',
    g = 'Goto',
    gf = 'file',
    r = 'Re...',
    t = 'Transpose/Term',
    w = 'LSP Workspace',
} }

local function _map(fn)
    return function(lst)
        return vim.tbl_map(fn, lst)
    end
end

local function wk_pre(args)
    local prefix, maps = unpack(args)
    local res = {}
    for k, v in pairs(maps) do
        res[k] = { name = v }
    end
    return { res, { prefix = prefix } }
end

local function wf_pre(args)
    local res = {}
    local prefix, maps = unpack(args)
    for k, v in pairs(maps) do
        res[prefix .. k] = v
    end
    return res
end

local wk_map = _map(wk_pre)
local wf_map = _map(wf_pre)

local function setup(plug, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 500
    if plug.name == 'which-key.nvim' then
        local wk = require 'which-key'

        wk.setup(opts.setup or {})
        for _, i in ipairs(wk_map(opts.prefixes or {})) do
            wk.register(unpack(i))
        end
    elseif plug.name == 'wf.nvim' then
        local wf = require 'wf'
        wf.setup(opts.setup or {})
        local wk_fnc

        -- we only set extra keys if included in specialized config
        -- (remember, this setup function is for the base config)
        if #tables.filter_eq(plug.keys, '<leader>') == 0 then return end
        local leader = vim.g.mapleader
        if leader == ' ' then leader = '<space>' end
        vim.keymap.set(
            'n',
            '<Leader>',
            function()
                if not wk_fnc then
                    wk_fnc = require 'wf.builtin.which_key' {
                        text_insert_in_advance = leader,
                        key_group_dict = vim.tbl_flatten(
                            wf_map(opts.prefixes or {})
                        ),
                    }
                end
                wk_fnc()
            end,
            { noremap = true, silent = false }
        )
        local bookmark = require 'wf.builtin.bookmark'
    end
end

local base = {
    [1] = '',
    enabled = false,
    opts = {
        setup = {},
        prefixes = {
            leader_key,
        },
    },
    config = setup,
}

local function wf_builtin(key, mod)
    return {
        '<leader>' .. key,
        function()
            local fc = 'wf_func_' .. mod
            if not _G[fc] then
                _G[fc] = require('wf.builtin.' .. mod)()
            end
            _G[fc]()
        end,
    }
end

return {
    vim.tbl_deep_extend('force', base, {
        'folke/which-key.nvim',
        enabled = true,
    }),
    vim.tbl_deep_extend('force', base, {
        'Cassin01/wf.nvim',
        enabled = true,
        keys = {
            -- '<leader>',
            wf_builtin('vwr', 'register'),
            wf_builtin('vwf', 'buffer'),
            wf_builtin('vwm', 'mark'),
            -- '<leader>wbm',
        },
    })
}
