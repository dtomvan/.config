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
R('gitsigns').setup()
R('telescope').setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}
R('telescope').load_extension('fzy_native')

R('nlua.lsp.nvim').setup(R('lspconfig'), {
  on_attach = custom_nvim_lspconfig_attach,

  -- Include globals you want to tell the LSP are real :)
  globals = {
    -- Colorbuddy
    "Color", "c", "Group", "g", "s", "use", "custom_nvim_lspconfig_attach",
  }
})
R'lsp_extensions'.inlay_hints {
    prefix = '',
    highlight = "Comment",
    enabled = {"TypeHint", "ChainingHint", "ParameterHint"}
}
R"termwrapper".setup {
    open_autoinsert = true,
    toggle_autoinsert = true,
    autoclose = true,
    winenter_autoinsert = false,
    default_window_command = "belowright 13split",
    open_new_toggle = true,
    log = 1, 
}
