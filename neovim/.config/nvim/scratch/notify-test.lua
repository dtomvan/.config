local notify = require 'notify'

local ok, noice = pcall(require, 'noice')
if ok then
    print 'Disabling noice as we need full control of the notification pipeline in this case'
    noice.disable()
end

local expandable_notifications = {}

notify.setup {}

vim.keymap.set('n', '<space>ne', function()
    if expandable_notifications[1] then
        expandable_notifications[1].callback()
        expandable_notifications:remove(1)
    end
end, { expr = true })

local function expandable_notification(title, message, level)
    notify('', level, {
        -- render = 'compact',
        title = title,
        on_open = function(wid)
            expandable_notifications:insert {
                wid = wid,
                callback = function()
                    vim.api.nvim_win_close(wid)
                    require 'notify'(message, level, { title = title })
                end,
            }
        end,
        on_close = function(wid)
            for i, notif in ipairs(expandable_notifications) do
                if notif.wid == wid then
                    expandable_notifications:remove(i)
                end
            end
        end,
    })
end

expandable_notification('ERROR', 'Some error', vim.log.levels.ERROR)
expandable_notification('WARNING', 'Some WARNING', vim.log.levels.WARN)
