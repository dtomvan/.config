return {
    'm4xshen/smartcolumn.nvim',
    event = 'BufReadPost',
    opts = {
        disabled_filetypes = {
            'help',
            'lazy',
            'markdown',
            'mason',
            'NvimTree',
            'text',
        },
    },
}
