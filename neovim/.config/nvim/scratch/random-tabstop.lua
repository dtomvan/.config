local B = require 'dtomvan.utils.buf'

-- Inspired by tj's jokes.nvim
local old_tabstop = {}
if _G._random_tabstop == nil then
    _G._random_tabstop = true
end
vim.keymap.set('i', '<tab>', function()
    if _G._random_tabstop then
        local random = math.random(8)
        local buf = B:from_current()
        old_tabstop[buf] = buf.bo.tabstop
        buf.bo.tabstop = random
        buf.bo.sw = random
        buf.bo.sts = random
        buf.bo.ai = false
        buf.bo.si = false
        buf.bo.ci = false
        return string.rep(' ', random)
    end
end, { desc = 'Evil tabstop', expr = true })

vim.api.nvim_create_user_command('ToggleTabstop', function(_)
    if _G._random_tabstop then
        vim.notify 'Toggling tabstop off'
        _G._random_tabstop = false
        for buf, tabstop in pairs(old_tabstop) do
            buf.tabstop = tabstop
            buf.shiftwidth = tabstop
            buf.softtabstop = tabstop
            buf.autoindent = true
            buf.smartindent = true
            buf.copyindent = true
        end
    else
        vim.notify 'Toggling tabstop on'
        _G._random_tabstop = true
    end
end, { desc = 'Toggles to the tabstop "joke"', force = true })
