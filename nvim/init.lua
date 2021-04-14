    -- _   ____________ _    ________  ___
   -- / | / / ____/ __ \ |  / /  _/  |/  /
  -- /  |/ / __/ / / / / | / // // /|_/ /
 -- / /|  / /___/ /_/ /| |/ // // /  / /
-- /_/ |_/_____/\____/ |___/___/_/  /_/
require("plugins")
require('colorbuddy').colorscheme('gruvbuddy')
require('lsp')
require('opts')
require('keymaps')
require('stuffthatiknowtodoinvimscriptbutnotinlua')
require'lspconfig'.rust_analyzer.setup {}
require'lsp_extensions'.inlay_hints {
    prefix = '',
    highlight = "Comment",
    enabled = {"TypeHint", "ChainingHint", "ParameterHint"}
}
