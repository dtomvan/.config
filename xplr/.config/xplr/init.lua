---@diagnostic disable-next-line: lowercase-global
version = "0.17.0"

local home = os.getenv("HOME")

package.path = package.path
	.. ";"
	.. home
	.. "/.config/xplr/plugins/?/src/init.lua;"
	.. home
	.. "/.config/xplr/plugins/?/init.lua;"
	.. home
	.. "/.config/xplr/?.lua;"
	.. home
	.. "/.config/xplr/modes/?.lua;"

-- Config
---- General
require("general")
-- Layouts
require("layouts")
-- Modes
require("modes")
-- Custom
xplr.fn.custom = {}
-- Commands
-- Needed to use the commands.lua file
require("command-mode").setup()
-- Actual config
require("commands")
-- Plugins
require("fzf").setup()
require("map").setup()
require("completion").setup()
require("type-to-nav").setup()
require("zoxide").setup()
require("dragon").setup()
require("icons").setup()
require("icons-prncss-xyz").setup()
require("dual-pane").setup()

local term = require("term")
local k_hsplit = term.profile_tmux_hsplit()
k_hsplit.key = "ctrl-h"
term.setup({ term.profile_tmux_vsplit(), k_hsplit })

require("xclip").setup()
require("context-switch").setup()
require("ouch").setup()
