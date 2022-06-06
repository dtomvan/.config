--     _   ____________ _    ________  ___
--    / | / / ____/ __ \ |  / /  _/  |/  /
--   /  |/ / __/ / / / / | / // // /|_/ /
--  / /|  / /___/ /_/ /| |/ // // /  / /
-- /_/ |_/_____/\____/ |___/___/_/  /_/

vim.g.did_load_filetypes = 1

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
    execute 'packadd packer.nvim'
end

package.loaded.globals = nil
require 'dtomvan.globals'
R 'dtomvan.plugins'
R 'dtomvan.opts'
R 'dtomvan.lsp'
R 'dtomvan.keymaps'
R 'dtomvan.au'
R 'dtomvan.cmd'

-- abbreviations
EX.noreabbrev('fcd', 'cd %:p:h')
EX.noreabbrev('help', 'Telescope help_tags')
