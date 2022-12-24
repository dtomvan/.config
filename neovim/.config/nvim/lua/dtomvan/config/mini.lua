local util = require 'dtomvan.utils'
local sessions = require 'mini.sessions'
sessions.setup {}

local function saction(a)
    return function() MiniSessions.select(a) end
end

vim.keymap.set('n', '<leader>sr', saction('read'))
vim.keymap.set('n', '<leader>sw', saction('write'))
vim.keymap.set('n', '<leader>sd', saction('delete'))
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
                util.yes_or_no("Do you want to overwrite the existing session", false, function(b)
                    if b then
                        MiniSessions.write(input, { force = true })
                    end
                end)
            end
        end
        if existing then return end
        MiniSessions.write(input, {})
    end)
end)

local starter = require 'mini.starter'
starter.setup {
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
