    -- _   ____________ _    ________  ___
   -- / | / / ____/ __ \ |  / /  _/  |/  /
  -- /  |/ / __/ / / / / | / // // /|_/ /
 -- / /|  / /___/ /_/ /| |/ // // /  / /
-- /_/ |_/_____/\____/ |___/___/_/  /_/
package.loaded.plugins = nil
package.loaded.lsp = nil
package.loaded.opts = nil
package.loaded.keymaps = nil
package.loaded.stuffthatiknowtodoinvimscriptbutnotinlua = nil
require("plugins")
require('colorbuddy').colorscheme('onebuddy')
require('lsp')
require('opts')
require('keymaps')
require('stuffthatiknowtodoinvimscriptbutnotinlua')
require'lspconfig'.rust_analyzer.setup{}
require'lsp_extensions'.inlay_hints {
    prefix = '',
    highlight = "Comment",
    enabled = {"TypeHint", "ChainingHint", "ParameterHint"}
}
require"termwrapper".setup {
    open_autoinsert = true,
    toggle_autoinsert = true,
    autoclose = true,
    winenter_autoinsert = false,
    default_window_command = "belowright 13split",
    open_new_toggle = true,
    log = 1, 
}
