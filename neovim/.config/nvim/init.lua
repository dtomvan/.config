vim.g.did_load_filetypes = 1
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
