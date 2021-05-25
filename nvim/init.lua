    -- _   ____________ _    ________  ___
   -- / | / / ____/ __ \ |  / /  _/  |/  /
  -- /  |/ / __/ / / / / | / // // /|_/ /
 -- / /|  / /___/ /_/ /| |/ // // /  / /
-- /_/ |_/_____/\____/ |___/___/_/  /_/
package.loaded.globals = nil
require("globals")
R("plugins")
R('colorbuddy').colorscheme('onebuddy')
R('lsp')
R('opts')
R('keymaps')
R('stuffthatiknowtodoinvimscriptbutnotinlua')
R('gitsigns').setup{}
R('telescope').setup {}
R('nlua.lsp.nvim').setup(R('lspconfig'), {
  on_attach = custom_nvim_lspconfig_attach,
  globals = {
    "Color", "c", "Group", "g", "s", "use", "custom_nvim_lspconfig_attach",
  }
})
