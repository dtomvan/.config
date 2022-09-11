vim.keymap.set('i', '<enter>', function()
    local mark = vim.api.nvim_win_get_cursor(0)
    local row = mark[1]
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)
    if not line[1] then
        return '<enter>'
    end
    if string.find(line[1], '\t') and #line[1] ~= 0 then
        return '<enter>'
    else
        return '<tab>'
    end
end, { buffer = true, expr = true, remap = false })

vim.b.autopairs_enabled = false
vim.b.autopairs_loaded = true
vim.bo.et = false
vim.bo.ci = false
vim.bo.si = false
vim.bo.ai = false
vim.wo.spell = true
