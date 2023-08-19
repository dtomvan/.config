if vim.loader then
    pcall(vim.loader.enable)
end

---@diagnostic disable: no-unknown
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.g.firenvim_config = {
    localSettings = { ['.*'] = { takeover = 'never' } },
}

require 'dtomvan.globals'
require 'dtomvan.filetypes'
require 'dtomvan.au'
require 'dtomvan.opts'
require 'dtomvan.lazy'
require 'dtomvan.keymaps'
require 'dtomvan.cmd'
require 'dtomvan.paste'

-- My rendition of the result of
-- `opam user-setup install`
require 'dtomvan.opam'

vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        vim.schedule_wrap(function()
            require 'dtomvan.skip_backwards_range'
        end)
    end,
    once = true,
})
