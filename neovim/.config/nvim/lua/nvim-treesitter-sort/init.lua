local M = {}

function M.init()
    local query = require 'nvim-treesitter.query'
    require('nvim-treesitter').define_modules {
        sort = {
            alphabetically = {
                module_path = 'nvim-treesitter-sort.alphabetically',
                enable = { 'rust' },
                is_supported = query.has_locals,
            },
        },
    }
end

return M
