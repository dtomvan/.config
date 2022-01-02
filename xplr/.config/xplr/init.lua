-- Lsp trick
xplr = xplr
version = "0.16.4"

package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'
package.path = package.path .. ";" .. os.getenv("HOME") .. '/.config/xplr/?.lua'
package.path = package.path .. ";" .. os.getenv("HOME") .. '/.config/xplr/modes/?.lua'

-- Config
---- General
require('general')
-- Layouts
require('layouts')
-- Modes
require('modes')
-- Custom
xplr.fn.custom = {}
-- Commands
-- Needed to use the commands.lua file
require("command-mode").setup()
-- Actual config
require('commands')
-- Plugins
require("fzf").setup()
require("map").setup()
require("completion").setup()
require("type-to-nav").setup()
require("zoxide").setup()
require("dragon").setup()
require("icons").setup()
require("icons-prncss-xyz").setup()

local term = require('term')
local k_hsplit = term.profile_tmux_hsplit()
k_hsplit.key = 'ctrl-h'
term.setup({term.profile_tmux_vsplit(), k_hsplit})

require("xclip").setup()
require("context-switch").setup()
require("ouch").setup()
