return {
    'numToStr/Comment.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = {},
    keys = {
        'gcc',
        'gbc',
        { 'gc', mode = { 'n', 'v' } },
        { 'gb', mode = { 'n', 'v' } },
        'gcO',
        'gco',
        'gcA',
    },
    opts = function()
        -- Hehe, textwidth
        local c = require 'ts_context_commentstring.integrations.comment_nvim'
        local h = c.create_pre_hook()
        return {
            pre_hook = h
        }
    end
}
