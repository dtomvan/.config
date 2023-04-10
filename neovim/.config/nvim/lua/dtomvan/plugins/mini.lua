local function mini_req(plug, opts)
    local sp = vim.split(plug[1], '.', { plain = true })
    require('mini.' .. sp[#sp]).setup(opts)
end

return {
    {
        'echasnovski/mini.animate',
        version = '*',
        event = 'VimEnter',
        config = mini_req,
        opts = function()
            -- don't use animate when scrolling with the mouse
            local mouse_scrolled = false
            for _, scroll in ipairs({ "Up", "Down" }) do
                local key = "<ScrollWheel" .. scroll .. ">"
                vim.keymap.set({ "", "i" }, key, function()
                    mouse_scrolled = true
                    return key
                end, { expr = true })
            end

            local animate = require 'mini.animate'
            return {
                scroll = {
                    timing = animate.gen_timing.linear {
                        duration = 5,
                    },
                    subscroll = animate.gen_subscroll.equal {
                        predicate = function(t)
                            if mouse_scrolled then
                                mouse_scrolled = false
                                return false
                            end
                            return t > 1
                        end,
                    },
                },
                cursor = { enable = false },
                resize = { enable = false },
                open = {
                    timing = animate.gen_timing.linear { duration = 400, unit = 'total' },
                    winconfig = animate.gen_winconfig.wipe { direction = 'from_edge' },
                    winblend = animate.gen_winblend.linear { from = 40, to = 100 },
                },
                close = {
                    timing = animate.gen_timing.linear { duration = 400, unit = 'total' },
                    winconfig = animate.gen_winconfig.wipe { direction = 'to_edge' },
                    winblend = animate.gen_winblend.linear { from = 100, to = 40 },
                },
            }
        end
    },
    {
        'echasnovski/mini.starter',
        dependencies = {
            'dtomvan/starter-birthday.nvim',
            opts = {
                username = 'Tom',
                date = {
                    day = 20,
                    month = 12,
                },
            },
        },
        config = CONF.starter,
    },
    {
        'echasnovski/mini.sessions',
        config = CONF.sessions,
    },
    {
        'echasnovski/mini.bufremove',
        keys = {
            {
                '<leader>bd',
                function()
                    require('mini.bufremove').delete(0, false)
                end,
                desc = 'Delete Buffer',
            },
            {
                '<leader>bD',
                function()
                    require('mini.bufremove').delete(0, true)
                end,
                desc = 'Delete Buffer (Force)',
            },
        },
    },
    {
        'echasnovski/mini.indentscope',
        version = '*',
        event = 'FileType',
        config = mini_req,
        opts = {
            symbol = '│',
        },
    },
    {
        'echasnovski/mini.bracketed',
        version = '*',
        event = 'VeryLazy',
        config = mini_req,
    },
}
