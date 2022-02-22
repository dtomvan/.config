---@diagnostic disable-next-line: lowercase-global
version = '0.17.0'

local home = os.getenv 'HOME'

package.path = package.path .. ';' .. home .. '/.config/xplr/?.lua;' .. home .. '/.config/xplr/modes/?.lua;'

local xpm_path = '.local/share/xplr/xpm.xplr/'
local xpm_url = 'https://github.com/dtomvan/xpm.xplr'
package.path = package.path
    .. ';'
    .. home
    .. '/'
    .. xpm_path
    .. '?.lua;'
    .. home
    .. '/'
    .. xpm_path
    .. '?/init.lua;'
os.execute(string.format('ls ~/%s >/dev/null || git clone %s ~/%s', xpm_path, xpm_url, xpm_path))

-- Config
---- General
require 'general'
-- Layouts
require 'layouts'
-- Modes
require 'modes'
-- Plugins
require('xpm').setup {
    {
        'sayanarijit/command-mode.xplr',
        after = function()
            require 'commands'
        end,
    },
    'https://github.com/dtomvan/icons.xplr',
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
    'sayanarijit/map.xplr',
    'sayanarijit/xclip.xplr',
    'sayanarijit/zoxide.xplr',
}
