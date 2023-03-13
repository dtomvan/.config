return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    dependencies = 'levouh/tint.nvim',
    build = ':CatppuccinCompile',
    opts = {
        integrations = {
            cmp = true,
            gitsigns = true,
            harpoon = true,
            leap = true,
            lsp_trouble = true,
            markdown = true,
            mason = true,
            mini = true,
            navic = true,
            neogit = true,
            noice = true,
            notify = true,
            octo = true,
            semantic_tokens = true,
            symbols_outline = true,
            telescope = true,
            treesitter_context = true,
            treesitter = true,
            which_key = true,
        },
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
                errors = { 'italic' },
                hints = { 'italic' },
                warnings = { 'italic' },
                information = { 'italic' },
            },
            underlines = {
                errors = { 'underline' },
                hints = { 'underline' },
                warnings = { 'underline' },
                information = { 'underline' },
            },
        },
        navic = {
            enabled = true,
        },
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
    },
    config = function(_, opts)
        require('catppuccin').setup(opts)

        vim.cmd.colorscheme 'catppuccin'
        if vim.fn.has 'nvim-0.8' then
            local ok, tint = pcall(require, 'tint')
            if vim.api.nvim_win_set_hl_ns and ok then
                tint.setup {
                    tint = -23,
                    saturation = 0.6,
                    tint_background_colors = false,
                    highlight_ignore_patterns = {
                        'WinSeparator',
                        'Status.*',
                        'Telescope.*',
                    },
                    window_ignore_function = function(winid)
                        local bufid = vim.api.nvim_win_get_buf(winid)
                        local floating = vim.api.nvim_win_get_config(winid).relative
                            ~= ''

                        return vim.api.nvim_buf_get_option(bufid, 'buftype')
                            == 'terminal'
                            or floating
                    end,
                }
            end
        end
    end,
}
