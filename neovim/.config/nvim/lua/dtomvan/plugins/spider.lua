local keymaps = require 'dtomvan.keymaps'
local treesitter_fts

return {
    'chrisgrieser/nvim-spider',
    opts = {
        skipInsignificantPunctuation = true,
    },
    keys = { 'w', 'e', 'b', 'ge' },
    init = function()
        for _, i in ipairs { 'w', 'e', 'b', 'ge' } do
            keymaps.confusing({ 'n', 'x' }, i,
                function()
                    if not treesitter_fts then
                        treesitter_fts =
                            vim.tbl_keys(
                                require 'nvim-treesitter.parsers'.get_parser_configs()
                            )
                    end
                    if treesitter_fts[vim.bo.ft] then
                        require('spider').motion(i)
                        return ''
                    end
                    return i
                end,
                {
                    desc = 'Spider-' .. i,
                    expr = true,
                }
            )
        end
    end
}
