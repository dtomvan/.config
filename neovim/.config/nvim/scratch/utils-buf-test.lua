local Buffer = require 'dtomvan.utils.buf'
local buf = Buffer:create()
require 'dtomvan.utils'.debug 'buf'
buf:delete()
vim.print(buf:exists())
buf:wipeout()
vim.print(buf:exists())
