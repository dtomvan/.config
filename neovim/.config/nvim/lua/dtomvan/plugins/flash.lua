return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
        {
            "<cr>",
            mode = { "n", "x", "o" },
            function() require("flash").jump() end,
            desc = "Flash",
        },
        {
            ',<cr>',
            '<cr>',
            remap = false,
            desc = '<cr>',
        },
        {
            ',s',
            's',
            remap = false,
            desc = 's',
        },
        {
            "S",
            mode = { "n", "o", "x" },
            function() require("flash").treesitter() end,
            desc =
            "Flash Treesitter"
        },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        {
            "R",
            mode = { "o", "x" },
            function() require("flash").treesitter_search() end,
            desc =
            "Treesitter Search"
        },
        {
            "<c-s>",
            mode = { "c" },
            function() require("flash").toggle() end,
            desc =
            "Toggle Flash Search"
        },
        {
            '*',
            function() require("flash").jump({ pattern = vim.fn.expand("<cword>") }) end,
            desc = 'Flash jump to word',
        },
        {
            ',*',
            '*',
            remap = false,
        },
    },
}
