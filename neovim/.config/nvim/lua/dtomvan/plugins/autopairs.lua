local function all(rules)
    return function(...)
        local result = true
        for _, rule in ipairs(rules) do
            local r = rule(...)
            if r ~= nil then
                result = result and r
            end
        end
        return type(result) == 'boolean' and result or false
    end
end

return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
        disable_in_macro = true,
        disable_in_visualblock = true,
        enable_bracket_in_quote = false,
        check_ts = true,
        map_c_w = true,
        map_cr = true,
        map_bs = true,
        fast_wrap = {},
    },
    config = function(_, c)
        local npairs = require 'nvim-autopairs'
        local rule = require 'nvim-autopairs.rule'
        local conds = require 'nvim-autopairs.conds'
        local ts_conds = require 'nvim-autopairs.ts-conds'

        npairs.setup(c)
        for _, i in ipairs { 'elixir', 'lua', 'ruby' } do
            npairs.add_rules(require('nvim-autopairs.rules.endwise-' .. i))
        end

        npairs.get_rule('{').not_filetypes = { 'lua' }
        local do_trailing_comma = all {
            ts_conds.is_ts_node { 'table_constructor' },
            -- TODO: Figure out what these should be. string.match shenanigans
            -- conds.before_regex '',
            -- conds.after_regex '',
        }

        npairs.add_rules {
            rule('{', '},', 'lua'):with_pair(do_trailing_comma),
            rule('{', '}', 'lua')
                :with_pair(conds.invert(do_trailing_comma))
                :with_del(conds.not_after_text '{},'),
        }
    end,
}
