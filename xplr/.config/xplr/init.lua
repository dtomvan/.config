-- Lsp trick
xplr = xplr
version = "0.15.0"

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
require("term").setup()
require("xclip").setup()
package.path = package.path .. ";" .. os.getenv("HOME") .. "/projects/?.xplr/src/init.lua"
require("ouch").setup()
