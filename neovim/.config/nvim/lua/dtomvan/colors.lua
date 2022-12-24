local M = {}

M.theme = function()
    return { 'catppuccin/nvim', name = 'catppuccin' }
end

---@param theme string | nil
M.load_theme = function(theme)
    theme = theme or 'catppuccin-mocha'

    local hl = vim.api.nvim_set_hl
    vim.cmd.colorscheme(theme)

    hl(0, 'WinSeparator', { bg = 'none' })
    -- hl(0, 'Normal', { bg = 'none' })
    -- hl(0, 'NormalFloat', { bg = 'none' })
    hl(0, 'LspComment', { link = 'Comment' })
    -- hl(0, 'TreesitterContext', { link = 'TabLine' })
    hl(0, 'CybuBackground', { link = 'Normal' })
    --
    if vim.fn.has 'nvim-0.8' then
        local ok, tint = pcall(require, 'tint')
        if vim.api.nvim_win_set_hl_ns and ok then
            ---@diagnostic disable-next-line: missing-parameter
            tint.setup()
        end
    end
end

return M
