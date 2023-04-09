local function install(plug)
    vim.g.started_by_firenvim = 1
    plug.wait = true
    require('lazy').load(plug)
    vim.fn['firenvim#install'](0)
end

return {
    'glacambre/firenvim',
    build = install,
    init = function(plug)
        vim.api.nvim_create_user_command('FireNvim', function()
            install(plug)
        end, { desc = 'Install FireNvim dependencies and extension' })
    end,
    config = function()
        vim.g._no_winbar = true
        vim.g._no_cmp = true
    end,
    cond = vim.g.started_by_firenvim and true or false,
}
