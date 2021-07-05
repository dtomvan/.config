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
---- Custom
xplr.fn.custom = {}
require("fzf").setup()
require("xargs").setup()
