return {
    'glacambre/firenvim',
    build = function()
        vim.g.started_by_firenvim = 1
        require('lazy').load 'firenvim'
        vim.fn['firenvim#install'](0)
    end,
    init = function()
        vim.api.nvim_create_user_command('FireNvim', function()
            vim.g.started_by_firenvim = 1
            -- WARN: require'lazy'.load(...) doesn't work
            vim.cmd.Lazy 'load firenvim'
            return vim.fn['firenvim#install'](0)
        end, { desc = 'Install FireNvim dependencies and extension' })
    end,
    config = function()
        vim.g._no_winbar = true
        vim.g._no_cmp = true
    end,
    cond = vim.g.started_by_firenvim and true or false,
}
