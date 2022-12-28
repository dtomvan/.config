local util = require 'dtomvan.utils'
local sessions = require 'mini.sessions'
sessions.setup {}

local function saction(a)
    return function()
        MiniSessions.select(a)
    end
end

vim.keymap.set('n', '<leader>sr', saction 'read')
vim.keymap.set('n', '<leader>sw', saction 'write')
vim.keymap.set('n', '<leader>sd', saction 'delete')
vim.keymap.set('n', '<leader>sn', function()
    local split = vim.split(vim.fn.getcwd(), '/')
    vim.ui.input({ prompt = 'Session name? ', default = split[#split] }, function(input)
        if input == nil then
            return
        end
        local existing = false
        for session in ipairs(MiniSessions.detected) do
            if session.name == input then
                existing = true
                util.yes_or_no('Do you want to overwrite the existing session', false, function(b)
                    if b then
                        MiniSessions.write(input, { force = true })
                    end
                end)
            end
        end
        if existing then
            return
        end
        MiniSessions.write(input, {})
    end)
end)

local starter = require 'mini.starter'
local started = false

local id = vim.api.nvim_create_augroup('LazyVimStats', { clear = true })
vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyVimStarted',
    group = id,
    callback = function()
        started = true
        starter.config.autoopen = true
        starter.on_vimenter()
    end,
})

local get_startuptime = function()
    if not started then
        return ''
    else
        local stats = require('lazy').stats()
        return ('\nLoaded %d packages in %dms'):format(stats.loaded, stats.startuptime)
    end
end
starter.setup {
    autoopen = false,
    header = function()
        local hour = tonumber(vim.fn.strftime '%H')
        -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
        local part_id = math.floor((hour + 4) / 8) + 1
        local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]
        local username = vim.loop.os_get_passwd()['username'] or 'dtomvan'

        return ('Good %s, %s%s'):format(day_part, username, get_startuptime())
    end,
    footer = '',
    items = {
        starter.sections.telescope(),
        starter.sections.sessions(),
        starter.sections.recent_files(),
        starter.sections.builtin_actions(),
    },
    content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning('center', 'center'),
    },
}

require('mini.pairs').setup {}
