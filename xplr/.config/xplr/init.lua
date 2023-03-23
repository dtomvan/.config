---@diagnostic disable-next-line: lowercase-global
version = '0.21.0'

local home = os.getenv 'HOME'

package.path = package.path .. ';' .. home .. '/.config/xplr/?.lua;' .. home .. '/.config/xplr/modes/?.lua;'

local xpm_path = home .. '/.local/share/xplr/dtomvan/xpm.xplr'
-- Uncomment when testing locally
-- xpm_path = home .. '/projects/xpm/'
local xpm_url = 'https://github.com/dtomvan/xpm.xplr'

package.path = package.path .. ';' .. xpm_path .. '/?.lua;' .. xpm_path .. '/?/init.lua'

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

package.path = package.path .. ';' .. home .. '/projects' .. '/?.xplr/init.lua'

-- General
require 'general'
-- Layouts
require 'layouts'
-- Modes
require 'modes'
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
        end,
    },
    {
        'Junker/nuke.xplr',
        setup = function()
            require('nuke').setup {
                open = {
                    run_executables = true, -- default: false
                    custom = {
                        { mime_regex = '^image/.*', command = 'sxiv {}' },
                        { mime_regex = '^video/.*', command = 'mpv {}' },
                        { mime_regex = '^inode/directory$', command = 'mpv {}' },
                        { mime_regex = '.*', command = 'xdg-open {}' },
                    },
                },
                view = {
                    show_line_numbers = true, -- default: false
                },
                smart_view = {
                    custom = {
                        { extension = 'so', command = 'ldd -r {} | less' },
                    },
                },
            }
        end,
        after = function()
            local key = xplr.config.modes.builtin.default.key_bindings.on_key

            key.v = {
                help = 'nuke',
                messages = { 'PopMode', { SwitchModeCustom = 'nuke' } },
            }
            key['f3'] = xplr.config.modes.custom.nuke.key_bindings.on_key.v
            key['enter'] = xplr.config.modes.custom.nuke.key_bindings.on_key.o
        end,
    },
}

-- package.path = ';' .. os.getenv 'LUA_PATH' .. ';' .. package.path
-- package.cpath = ';' .. os.getenv 'LUA_CPATH' .. ';' .. package.cpath

require 'col_renderer_hotfix'
