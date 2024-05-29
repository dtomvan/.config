local tbl = require 'dtomvan.utils.tables'

local M = {}

M.global_on_save_enabled = true

M.bufnr_on_save_enabled = {}
M.bufnr_server = {}

local function global_check(value)
    if not M.global_on_save_enabled then
        assert(
            not value,
            'Cannot enable buffer-local FoS if global FoS is disabled'
        )
    end
end

---@param ctx integer | string bufnr or "global"
M.enable_fmt_on_save = function(ctx)
    if ctx == 'global' then
        M.global_on_save_enabled = true
    else
        global_check(true)
        M.bufnr_on_save_enabled[ctx] = true
    end

    return 'on'
end

---@param ctx integer | string bufnr or "global"
M.disable_fmt_on_save = function(ctx)
    if ctx == 'global' then
        M.global_on_save_enabled = false
    else
        M.bufnr_on_save_enabled[ctx] = false
    end

    return 'off'
end

---@param ctx integer | string bufnr or "global"
M.toggle_fmt_on_save = function(ctx)
    local thing
    if ctx == 'global' then
        M.global_on_save_enabled = not M.global_on_save_enabled
        thing = M.global_on_save_enabled
    else
        local value = M.bufnr_on_save_enabled[ctx]
        if value == nil then
            value = true
        end
        value = not value
        global_check(value)
        M.bufnr_on_save_enabled[ctx] = value
        thing = value
    end

    return thing and 'on' or 'off'
end

M.do_format_on_save = function(bufnr)
    local b = M.bufnr_on_save_enabled[bufnr]
    return M.global_on_save_enabled and (b == nil and true or b)
end

M.get_formatting_clients = function(filter)
    return vim.tbl_filter(function(cl)
        -- TODO: Check wether the client is done loading, especially since there
        -- is a FoS bug with lua_ls when it hasn't loaded yet: neovim/neovim#22254
        return true
    end, tbl.multi_peek_filter_eq(
        vim.lsp.get_clients(filter),
        { 'server_capabilities', 'documentFormattingProvider' },
        true
    ))
end

M.set_bufnr_server = function(bufnr, name)
    assert(
        M.get_formatting_clients { bufnr = bufnr, name = name },
        'No such server ' .. name
    )
    M.bufnr_server[bufnr] = name
end

M.name_filter = function(name)
    return function(cl)
        return cl.name == name
    end
end

---@param bufnr integer
---@return lsp.Client | nil
---@return boolean multiple clients available?
M.buf_get_server = function(bufnr)
    local available = M.get_formatting_clients { bufnr = bufnr }
    if #available == 0 then
        return nil, false
    end

    local single = M.get_only_server(bufnr, available)
        or M.get_bufnr_server(bufnr, available)
        or M.get_ft_server(bufnr, available)
    if single then
        return single, false
    else
        return available, true
    end
end

M.ft_servers = {}
M.config_path = vim.fn.stdpath 'config' .. '/formatters.json'

M.save_ft_servers = function()
    local f = assert(io.open(M.config_path, 'w+'))
    f:write(vim.json.encode(M.ft_servers))
    f:close()
    vim.fn.system { 'python', '-m', 'json.tool', M.config_path, M.config_path }
end

M.load_ft_servers = function()
    local f = assert(io.open(M.config_path))
    M.ft_servers = vim.json.decode(f:read '*a') or {}
    f:close()
end
if not pcall(M.load_ft_servers) then
    M.ft_servers = {}
end

---@param bufnr integer
---@param name string
---@param persist boolean
M.save_ft_server = function(bufnr, name, persist)
    local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    local possible = M.get_formatting_clients { bufnr = bufnr, name = name }

    if #possible == 1 then
        M.ft_servers[ft] = name
        if persist then
            M.save_ft_servers()
        end
    else
        error('No such server ' .. name .. ' with correct capabilities')
    end
end

---@param bufnr integer
---@param available lsp.Client[]
---@return lsp.Client | nil
M.get_ft_server = function(bufnr, available)
    local ok, ft = pcall(vim.api.nvim_get_option_value, 'filetype', { buf = bufnr })
    if ok then
        local possible = tbl.peek_filter_eq(available, 'name', M.ft_servers[ft])
        if #possible == 1 then
            return possible[1]
        end
    end
end

---@param bufnr integer
---@param available lsp.Client[]
---@return lsp.Client | nil
M.get_bufnr_server = function(bufnr, available)
    local possible =
        tbl.peek_filter_eq(available, 'name', M.bufnr_server[bufnr])
    if #possible == 1 then
        return possible[1]
    end
end

---@param available lsp.Client[]
---@return lsp.Client | nil
M.get_only_server = function(_, available)
    if #available == 1 then
        return available[1]
    end
end

---@param b integer|nil
M.format_buf = function(b)
    local bufnr = b or vim.api.nvim_get_current_buf()
    local cl, multiple = M.buf_get_server(bufnr)
    if not cl then
        if not b and not M.bufnr_server[bufnr] then
            -- Assume interactive use when no bufnr is given
            vim.notify('no available server for formatting')
            M.bufnr_server[bufnr] = 'NONE'
        end
        return
    end

    if not multiple then
        vim.lsp.buf.format {
            filter = function(x)
                return x == cl
            end,
        }
        return
    end
    vim.ui.select(cl, {
        prompt = 'Which formatting client? -> ',
        format_item = function(x)
            return x.name
        end,
    }, function(item)
        if not item then
            return
        end
        M.bufnr_server[bufnr] = item.name
        if
            not pcall(vim.lsp.buf.format, {
                filter = function(x)
                    return x == item
                end,
                async = true,
            })
        then
            vim.lsp.buf.format { async = true }
        end
    end)
end

return M
