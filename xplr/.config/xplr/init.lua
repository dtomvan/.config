---@diagnostic disable-next-line: lowercase-global
version = '0.19.0'

local home = os.getenv 'HOME'

package.path = package.path .. ';' .. home .. '/.config/xplr/?.lua;' .. home .. '/.config/xplr/modes/?.lua;'

local xpm_path = home .. '/.local/share/xplr/dtomvan/xpm.xplr'
local xpm_url = 'https://github.com/dtomvan/xpm.xplr'

package.path = package.path .. ';' .. xpm_path .. '/?.lua;' .. xpm_path .. '/?/init.lua'

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

-- Layouts
require 'layouts'
-- Modes
require 'modes'
require 'general'
-- Plugins
require('xpm').setup {
    'dtomvan/xpm.xplr',
    {
        'sayanarijit/command-mode.xplr',
        after = function()
            require 'commands'
        end,
    },
    'dtomvan/ouch.xplr',
    'igorepst/context-switch.xplr',
    {
        'igorepst/term.xplr',
        setup = function()
            local term = require 'term'
            local k_hsplit = term.profile_tmux_hsplit()
            k_hsplit.key = 'ctrl-h'
            term.setup { term.profile_tmux_vsplit(), k_hsplit }
        end,
    },
    'prncss-xyz/icons.xplr',
    'prncss-xyz/type-to-nav.xplr',
    'sayanarijit/completion.xplr',
    'sayanarijit/dragon.xplr',
    'sayanarijit/dual-pane.xplr',
    'sayanarijit/fzf.xplr',
    'sayanarijit/xclip.xplr',
    'sayanarijit/zoxide.xplr',
    'dtomvan/paste-rs.xplr',
    'sayanarijit/zentable.xplr',
    {
        'dtomvan/extra-icons.xplr',
        after = function()
            xplr.config.general.table.row.cols[2] = { format = 'custom.icons_dtomvan_col_1' }
        end,
    },
    'sayanarijit/registers.xplr',
    {
        'sayanarijit/map.xplr',
        setup = function()
            require('map').setup {
                -- key = "m"
            }
        end
    }
}

-- package.path = ';' .. os.getenv 'LUA_PATH' .. ';' .. package.path
-- package.cpath = ';' .. os.getenv 'LUA_CPATH' .. ';' .. package.cpath
