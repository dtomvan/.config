if vim.loader then
    pcall(vim.loader.enable)
end

---@diagnostic disable: no-unknown
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.g.firenvim_config = {
    localSettings = {
        ['.*'] = { takeover = 'never' },
        [ [[.*github\.com.*]] ] = {
            takeover = 'always',
        },
    },
}

require 'dtomvan.globals'
require 'dtomvan.filetypes'
require 'dtomvan.rwds'
require 'dtomvan.au'
require 'dtomvan.opts'
require 'dtomvan.lazy'
require 'dtomvan.keymaps'
require 'dtomvan.cmd'
require 'dtomvan.paste'

if vim.g.started_by_firenvim then return end
-- My rendition of the result of
-- `opam user-setup install`
require 'dtomvan.opam'
