package.loaded['dtomvan.globals'] = nil
require 'dtomvan.globals'
require 'dtomvan.filetypes'

R 'dtomvan.opts'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.cmd.sp(
        'term://git clone --filter=blob:none --single-branch https://github.com/folke/lazy.nvim.git ' .. lazypath
    )
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup 'dtomvan.plugins'
R 'dtomvan.lsp'
R 'dtomvan.keymaps'
R 'dtomvan.au'
R 'dtomvan.cmd'
R('dtomvan.colors').load_theme()

-- abbreviations
vim.cmd.noreabbrev('fcd', 'cd %:p:h')
