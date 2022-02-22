--     _   ____________ _    ________  ___
--    / | / / ____/ __ \ |  / /  _/  |/  /
--   /  |/ / __/ / / / / | / // // /|_/ /
--  / /|  / /___/ /_/ /| |/ // // /  / /
-- /_/ |_/_____/\____/ |___/___/_/  /_/

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
    execute 'packadd packer.nvim'
end

package.loaded.globals = nil
require 'globals'
R 'plugins'
R 'config-xplr'
vim.cmd [[source ~/.config/nvim/autoload/vimscriptstuff.vim]]
R 'opts'
R 'lsp'
vim.cmd [[ au! VimEnter *.rs ]]
R 'keymaps'
