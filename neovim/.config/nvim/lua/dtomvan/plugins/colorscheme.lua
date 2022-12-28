return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    dependencies = 'levouh/tint.nvim',
    config = function()
        local hl = vim.api.nvim_set_hl
        vim.cmd.colorscheme 'catppuccin-mocha'

        hl(0, 'WinSeparator', { bg = 'none' })
        -- hl(0, 'Normal', { bg = 'none' })
        -- hl(0, 'NormalFloat', { bg = 'none' })
        -- hl(0, 'TreesitterContext', { link = 'TabLine' })
        hl(0, 'LspComment', { link = 'Comment' })
        hl(0, 'CybuBackground', { link = 'Normal' })
        hl(0, 'StatusLine', { link = 'Normal' })

        if vim.fn.has 'nvim-0.8' then
            local ok, tint = pcall(require, 'tint')
            if vim.api.nvim_win_set_hl_ns and ok then
                tint.setup { tint = -20, saturation = 0.6 }
            end
        end
    end,
}
