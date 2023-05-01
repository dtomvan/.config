-- NOT WORKING, see TODO
local api = vim.api
local ts_utils = require 'nvim-treesitter.ts_utils'
local get_node_text = vim.treesitter.get_node_text

---@type TableUtils
local tables = require 'dtomvan.utils.tables'


local function replace(self, node, range, new_text)
    local res = {
        range = range or ts_utils.node_to_lsp_range(node),
        newText = type(new_text) == 'function' and new_text or tostring(new_text)
    }
    if self then
        table.insert(self, res)
    end
    return self and self or res
end

local function find_typed_children(node, ty)
    return tables.multi_map_peek_filter_eq(vim.iter.totable(node:iter_children()),
        { function(x) return x[1]:type() end, function(x) return x[1] or x end }, ty)
end

local function get_name_lut(t, bufnr, ty)
    return vim.iter(t)
        :map(function(x)
            return { get_node_text(find_typed_children(x, ty)[1], bufnr), x }
        end)
        :totable()
end

local function sort_and_resolve(t, bufnr, ty)
    local lut = get_name_lut(t, bufnr, ty)
    table.sort(lut, function(a, b)
        return a[1] < b[1]
    end)
    -- Because we are appending at the same point, we need to reverse the
    -- alphabetical order
    return vim.iter(tables.map_get(lut, 2)):map(function(node)
        return get_node_text(node, bufnr)
    end):enumerate():rev()
end

local M = {}

M.create_cb = function(bufnr, handler)
    return function(args)
        local win = tables.map_peek_filter_eq(api.nvim_list_wins(), api.nvim_win_get_buf, bufnr)[1]
        if not win then return error('no window for bufnr ' .. bufnr) end
        local pos = api.nvim_win_get_cursor(win)
        return handler(bufnr, win, pos, args)
    end
end

function M.rust_clean_impl(bufnr, _, pos, args)
    local cur_node = vim.treesitter.get_node { bufnr = bufnr, pos = pos }
    if not cur_node then return error('Couldn\'t get current node') end
    local impl_block = cur_node
    repeat
        if not impl_block then
            error('no such impl-block')
        end
        impl_block = impl_block:parent()
    until impl_block:type() == 'impl_item'
    local impl_body = find_typed_children(impl_block, 'declaration_list')[1] or error('no impl body')

    -- TODO: HECKIN LSP EDITS
    local e = {}

    -- This range specifies the line number on which the impl block starts
    local r1, c1 = impl_body:range()
    local range = {
        start = {
            line = 2,
            character = 9,
        },
        ['end'] = {
            line = 2,
            character = 9,
        },
    }

    -- Empty impl block
    replace(e, impl_body, nil, '{\n}')

    -- Gather data
    local fns = find_typed_children(impl_body, 'function_item')
    local fns_ordered = sort_and_resolve(fns, bufnr, 'identifier')
    local types = find_typed_children(impl_body, 'type_item')
    local types_ordered = sort_and_resolve(types, bufnr, 'type_identifier')

    -- add functions in reverse alphabetical order
    for i, fn in fns_ordered do
        replace(e, nil, range, '\n' .. fn)
    end

    -- add types in reverse alphabetical order
    for i, ty in types_ordered do
        replace(e, nil, range, (i == #types and '{\n' or '\n') .. ty)
    end

    -- apply edits (why reverse?!@)
    vim.lsp.util.apply_text_edits(vim.iter(e):rev():totable(), bufnr, "utf-8")
end

M.attach = function(bufnr)
    api.nvim_buf_create_user_command(bufnr, "CleanImpl", M.create_cb(bufnr, M.rust_clean_impl), {
        desc = 'Cleanup Rust\'s `impl`-blocks.',
    })
end

M.detach = function(bufnr)
    api.nvim_buf_del_user_command(bufnr, 'CleanImpl')
end

return M
