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
    config = {
        templates = {
            'builtin',
            'user',
        },
    },
    init = function()
        vim.api.nvim_create_user_command('OverseerRestartLast', function()
            local overseer = require 'overseer'
            local tasks = overseer.list_tasks { recent_first = true }
            if vim.tbl_isempty(tasks) then
                vim.notify('No tasks found', vim.log.levels.WARN)
            else
                overseer.run_action(tasks[1], 'restart')
            end
        end, { desc = 'Restart last task' })
    end,
}
