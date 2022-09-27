-- Inspired by tj's jokes.nvim
local bo = vim.api.nvim_buf_set_option

local old_tabstop = {}
if _G._random_tabstop == nil then
    _G._random_tabstop = true
end
vim.keymap.set('i', '<tab>', function()
    if _G._random_tabstop then
        local random = math.random(8)
        local bufnr = vim.api.nvim_get_current_buf()
        old_tabstop[bufnr] = vim.api.nvim_buf_get_option(bufnr, 'tabstop')
        vim.bo.tabstop = random
        vim.bo.sw = random
        vim.bo.sts = random
        vim.bo.ai = false
        vim.bo.si = false
        vim.bo.ci = false
        return string.rep(' ', random)
    end
end, { desc = 'Evil tabstop', expr = true })

vim.api.nvim_create_user_command('ToggleTabstop', function(_)
    if _G._random_tabstop then
        vim.notify 'Toggling tabstop off'
        _G._random_tabstop = false
        for bufnr, tabstop in pairs(old_tabstop) do
            bo(bufnr, 'tabstop', tabstop)
            bo(bufnr, 'shiftwidth', tabstop)
            bo(bufnr, 'softtabstop', tabstop)
            bo(bufnr, 'autoindent', true)
            bo(bufnr, 'smartindent', true)
            bo(bufnr, 'copyindent', true)
        end
    else
        vim.notify 'Toggling tabstop on'
        _G._random_tabstop = true
    end
end, { desc = 'Toggles to the tabstop "joke"', force = true })
