return {
    'm4xshen/smartcolumn.nvim',
    cond = not vim.g._aoc,
    event = 'BufReadPost',
    opts = {
        disabled_filetypes = {
            'starter',
            'help',
            'lazy',
            'markdown',
            'mason',
            'NvimTree',
            'text',
        },
    },
}
