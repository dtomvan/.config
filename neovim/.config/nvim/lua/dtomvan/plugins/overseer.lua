return {
    'stevearc/overseer.nvim',
    cmd = {
        'OverseerBuild',
        'OverseerClearCache',
        'OverseerClose',
        'OverseerDeleteBundle',
        'OverseerInfo',
        'OverseerLoadBundle',
        'OverseerOpen',
        'OverseerQuickAction',
        'OverseerRestartLast',
        'OverseerRun',
        'OverseerRunCmd',
        'OverseerSaveBundle',
        'OverseerTaskAction',
        'OverseerToggle',
    },
    keys = {
        { '<leader>co', '<cmd>OverseerToggle<cr>' },
    },
    opts = {
        templates = {
            'builtin',
            'user',
        },
    },
    config = function(_, opts)
        require 'overseer'.setup(opts)
        return CONF.overseer()
    end,
    init = CONF['overseer-cmd'],
}
