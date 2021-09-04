-- Lsp trick
xplr = xplr
version = "0.14.3"

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
require("xargs").setup()
require("completion").setup()
require("type-to-nav").setup()
require("zoxide").setup()
