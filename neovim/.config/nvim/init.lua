-- vim.g.did_load_filetypes = 1
package.loaded.globals = nil
require 'dtomvan.globals'

R 'dtomvan.opts'
R 'dtomvan.plugins'
R 'dtomvan.lsp'
R 'dtomvan.keymaps'
R 'dtomvan.au'
R 'dtomvan.cmd'
R 'dtomvan.colors'.load_theme()

-- abbreviations
vim.cmd.noreabbrev('fcd', 'cd %:p:h')
