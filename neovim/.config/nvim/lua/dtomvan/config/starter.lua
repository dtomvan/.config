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
local bd_msg = 'Happy Birthday!'
local birthday = function()
    if os.date '%d%m' == '2012' then
        return {
            {
                action = function()
                    local bufnr = vim.api.nvim_create_buf(false, true)
                    vim.cmd.b(bufnr)
                    vim.api.nvim_buf_set_lines(0, 0, 0, false, require('dtomvan.ascii_art').birthday)
                end,
                name = bd_msg,
                section = '20th of december!',
            },
        }
    else
        return {}
    end
end
local birthday_hl = function(content)
    local coords = MiniStarter.content_coords(content, 'item')
    for _, c in ipairs(coords) do
        local unit = content[c.line][c.unit]
        local item = unit.item
        local hl = {
            'Error',
            'Float',
            'WarningMsg',
            'String',
            'Function',
            'Exception',
        }
        if item.name == bd_msg then
            table.remove(content[c.line], c.unit)
            for i = #item.name, 1, -1 do
                table.insert(content[c.line], c.unit, {
                    string = item.name:sub(i, i),
                    hl = hl[(i - 1) % #hl + 1],
                })
            end
            table.insert(content[c.line], c.unit, { string = '', type = 'item', item = item })
        end
    end
    return content
end
starter.setup {
    autoopen = false,
    header = function()
        local hour = tonumber(os.date '%H')
        -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
        local part_id = math.floor((hour + 4) / 8) + 1
        local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]
        local username = vim.loop.os_get_passwd()['username'] or 'dtomvan'

        return ('Good %s, %s%s'):format(day_part, username, get_startuptime())
    end,
    footer = '',
    items = {
        birthday(),
        starter.sections.sessions(),
        starter.sections.recent_files(10),
    },
    content_hooks = {
        birthday_hl,
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning('center', 'center'),
    },
}
