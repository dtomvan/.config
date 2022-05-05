--     _   ____________ _    ________  ___
--    / | / / ____/ __ \ |  / /  _/  |/  /
--   /  |/ / __/ / / / / | / // // /|_/ /
--  / /|  / /___/ /_/ /| |/ // // /  / /
-- /_/ |_/_____/\____/ |___/___/_/  /_/

vim.g.did_load_filetypes = 1

local execute = vim.api.nvim_command
local fn = vim.fn
local hl = vim.api.nvim_set_hl

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
    execute 'packadd packer.nvim'
end

package.loaded.globals = nil
require 'dtomvan.globals'
R 'dtomvan.plugins'
R 'dtomvan.config-xplr'
R 'dtomvan.opts'
R 'dtomvan.lsp'
R 'dtomvan.keymaps'
R 'dtomvan.au'
R 'dtomvan.cmd'

hl(0, 'WinSeparator', { bg = 'NONE' })

-- abbreviations
local api = vim.api

local ex = setmetatable({}, {
    __index = function(t, k)
      local command = k:gsub("_$", "!")
      local f = function(...)
        return api.nvim_command(table.concat(vim.tbl_flatten {command, ...}, " "))
      end
      rawset(t, k, f)
      return f
    end
  });

ex.noreabbrev("luf", "luafile")
ex.noreabbrev("fcd", "cd %:p:h")
