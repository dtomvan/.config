return {
    "m4xshen/hardtime.nvim",
    cond = vim.g.started_by_firenvim == nil,
    event = 'UIEnter',
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
        restricted_keys = {
            ['<CR>'] = {},
        },
        disabled_filetypes = {
            'crates.nvim',
            'harpoon',
            'lazy',
            'mason',
            'neo-tree',
            'netrw',
            'NvimTree',
            'oil',
            'qf',
        },
        disable_mouse = false,
        hints = {
            ['<C%-W>[hjkl]'] = {
                message = function(keys)
                    return 'Use <A-' .. keys:sub(6) .. '> instead of ' .. keys
                end,
                length = 6,
            },
            ["k%^"] = {
                message = function()
                    return "Use - instead of k^"
                end,
                length = 2,
            },
            ["d[tTfF].i"] = {
                message = function(keys)
                    return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 4,
            },
        }
    },
}
