return {
    "ggandor/leap.nvim",
    event = "BufReadPost",
    dependencies = {
        { "ggandor/flit.nvim", config = { labeled_modes = "nv" } },
        { "ggandor/leap-spooky.nvim", config = true },
        {
            "ggandor/leap-ast.nvim",
            lazy = true,
            keys = {
                { "<leader>la", function() require 'leap-ast'.leap() end, mode = { 'n', 'x', 'o' } }
            },
        },
    },
    config = function()
        require("leap").add_default_mappings()

        vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
        vim.api.nvim_set_hl(0, 'LeapMatch', {
            fg = 'white', -- for light themes, set to 'black' or similar
            bold = true,
            nocombine = true,
        })
        require('leap').opts.highlight_unlabeled_phase_one_targets = true
    end,
}
