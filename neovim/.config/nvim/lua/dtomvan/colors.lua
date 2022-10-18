local M = {}

M.my_themes = {
    kanagawa = 'rebelot/kanagawa.nvim',
    templeos = 'LunarVim/templeos.nvim',
    horizon = 'LunarVim/horizon.nvim',
}

---@param use fun(plugin: string): any
M.use_themes = function(use)
    vim.validate { use = { use, 'function', true } }
    if not use then
        return
    end
    for _, repo in pairs(M.my_themes) do
        use(repo)
    end
end

---@param theme string | nil
M.load_theme = function(theme)
    theme = theme or 'kanagawa'

    local hl = vim.api.nvim_set_hl
    vim.cmd.colorscheme(theme)

    hl(0, 'WinSeparator', { bg = 'NONE' })
    hl(0, 'NormalFloat', { bg = 'NONE' })
    hl(0, 'LspComment', { link = 'Comment' })
    hl(0, 'TreesitterContext', { link = 'TabLine' })
    hl(0, 'CybuBackground', { link = 'Normal' })

    if vim.fn.has 'nvim-0.8' then
        local ok, tint = pcall(require, 'tint')
        if vim.api.nvim_win_set_hl_ns and ok then
            ---@diagnostic disable-next-line: missing-parameter
            tint.setup()
        end
    end
end

return M
