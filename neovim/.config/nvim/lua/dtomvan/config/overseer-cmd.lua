local flags = require 'dtomvan.rg_flags'
local tbl = require 'dtomvan.utils.tables'
local cmd = vim.api.nvim_create_user_command

cmd('OverseerRestartLast', function()
    local overseer = require 'overseer'
    local tasks = overseer.list_tasks { recent_first = true }
    if vim.tbl_isempty(tasks) then
        vim.notify('No tasks found', vim.log.levels.WARN)
    else
        overseer.run_action(tasks[1], 'restart')
    end
end, { desc = 'Restart last task' })

cmd('Make', function(params)
    local task = require('overseer').new_task {
        cmd = vim.split(vim.o.makeprg, '%s+'),
        args = params.fargs,
        components = {
            { 'on_output_quickfix', open = not params.bang, open_height = 8 },
            'default',
        },
    }
    task:start()
end, {
    desc = '',
    nargs = '*',
    bang = true,
})

cmd('Lazygit', function(params)
    local overseer = require 'overseer'

    local args = 'lazygit ' .. vim.fn.expandcmd(params.args)

    local task = overseer.new_task {
        cmd = args,
        name = args,
        components = {
            { 'on_complete_notify',  statuses = { 'FAILURE' } },
            { 'on_complete_dispose', timeout = 30 },
            'default',
        },
        strategy = {
            'toggleterm',
            on_create = function(term)
                vim.wo[term.window].winblend = 30
            end,
            direction = 'float',
            close_on_exit = true,
        },
    }
    task:start()
end, {
    nargs = '*',
    force = true,
    desc = 'Open Lazygit with arguments.',
    complete = function(lead)
        return tbl.filter_startswith({
            'branch',
            'log',
            'stash',
            'status',
        }, lead)
    end,
})

cmd('Rg', function(params)
    local overseer = require 'overseer'

    local args = vim.fn.expandcmd(params.args)
    local command, num_subs = vim.o.grepprg:gsub('%$%*', args)

    if num_subs == 0 then
        command = command .. ' ' .. args
    end
    local task = overseer.new_task {
        cmd = command,
        name = 'grep ' .. args,
        components = {
            {
                'on_output_quickfix',
                errorformat = vim.o.grepformat,
                open = not params.bang,
                open_height = 8,
                items_only = true,
            },
            'default',
        },
    }
    task:start()
end, {
    bang = true,
    nargs = '+',
    force = true,
    desc = 'Open ripgrep output in the quickfix list.',
    complete = function(lead, _, _)
        local possible = {}
        for _, flag in ipairs(flags) do
            if vim.startswith(flag, lead) then
                table.insert(possible, flag)
            end
        end
        return possible
    end,
})
