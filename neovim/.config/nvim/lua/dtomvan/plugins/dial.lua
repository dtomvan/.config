return {
    'monaqa/dial.nvim',
    keys = {
        { mode = "v", "<C-a>", function() require("dial.map").inc_visual("visual") end },
        { mode = "v", "<C-x>", function() require("dial.map").dec_visual("visual") end },
    },
    opts = function(_, opts)
        local augend = require 'dial.augend'
        return vim.tbl_deep_extend('keep',
            {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                },
                typescript = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.constant.new { elements = { "let", "const" } },
                },
                visual = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                },
            }, opts)
    end,
    config = function(_, opts)
        require("dial.config").augends:register_group(opts)
    end,
}
