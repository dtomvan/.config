return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    dependencies = 'levouh/tint.nvim',
    build = ':CatppuccinCompile',
    config = function()
        require 'catppuccin'.setup {
            flavour = 'mocha',
            custom_highlights = function()
                return {
                    WinSeparator = { bg = 'none' },
                    LspComment = { link = 'Comment' },
                    CybuBackground = { link = 'Normal' },
                    StatusLine = { link = 'Normal' },
                }
            end,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
        }

        vim.cmd.colorscheme 'catppuccin'
        if vim.fn.has 'nvim-0.8' then
            local ok, tint = pcall(require, 'tint')
            if vim.api.nvim_win_set_hl_ns and ok then
                tint.setup { tint = -23, saturation = 0.6 }
            end
        end
    end,
}
