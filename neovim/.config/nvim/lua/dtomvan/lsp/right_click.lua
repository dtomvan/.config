-- From: Gabmus' nvpunk
local M = {}

--- Checks if current buf has DAP support
---@return boolean
M.buf_has_dap = function()
    -- TODO
    return true
end

--- Create a context menu
---@param prompt string
---@param strings table[string]
---@param funcs table[function]
M.uiselect_context_menu = function(prompt, strings, funcs)
    vim.ui.select(strings, { prompt = prompt }, function(_, idx)
        vim.schedule(funcs[idx])
    end)
end

local MODES = { 'i', 'n' }

--- Clear all entries from the given menu
---@param menu string
M.clear_menu = function(menu)
    pcall(function()
        vim.cmd('aunmenu ' .. menu)
    end)
end

--- Escapes spaces
---@param label string
M.format_menu_label = function(label)
    return string.gsub(label, ' ', [[\ ]])
end

--- Create an entry for the right click menu
---@param menu string
---@param label string
---@param action string
M.rclick_context_menu = function(menu, label, action)
    for _, m in ipairs(MODES) do
        vim.cmd(m .. 'menu ' .. menu .. '.' .. M.format_menu_label(label) .. ' ' .. action)
    end
end

--- Set up a right click submenu
---@param menu_name string
---@param submenu_label string
---@param items table[{string, string}]
---@param bindif function?
M.set_rclick_submenu = function(menu_name, submenu_label, items, bindif)
    M.clear_menu(menu_name)
    M.clear_menu('PopUp.' .. M.format_menu_label(submenu_label))
    if bindif ~= nil then
        if not bindif() then
            return
        end
    end
    for _, i in ipairs(items) do
        M.rclick_context_menu(menu_name, i[1], i[2])
    end
    M.rclick_context_menu('PopUp', submenu_label, '<cmd>popup ' .. menu_name .. '<cr>')
end

M.set_lsp_rclick_menu = function()
    M.set_rclick_submenu('LspMenu', 'LSP         ', {
        { 'Code Actions', '<leader>a' },
        { 'Go to Declaration', 'gD' },
        { 'Go to Definition', 'gd' },
        { 'Go to Implementation', 'gi' },
        { 'Signature Help', '<C-k>' },
        { 'Rename', '<space>rn' },
        { 'Find References', 'gr' },
        { 'Expand Diagnostics', '<space>e' },
        { 'Format Buffer', '<c-f>' },
    }, function()
        return true
    end)
end

M.set_dap_rclick_menu = function()
    M.set_rclick_submenu('DapMenu', 'Debug       ', {
        { 'Show DAP UI', '<space>bu' },
        { 'Toggle Breakpoint', '<space>bb' },
        { 'Continue', '<space>bc' },
        { 'Terminate', '<space>bk' },
    }, M.buf_has_dap)
end

M.set_filetree_rclick_menu = function()
    M.set_rclick_submenu('FileTreeMenu', 'File        ', {
        { 'New File', '<space>fn' },
        { 'Rename', '<F2>' },
    }, function()
        return vim.bo.ft == 'NvimTree' or vim.bo.ft == 'CHADtree'
    end)
end

M.clear_menu 'PopUp'

return M
