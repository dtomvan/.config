M = {}

local tables = require 'dtomvan.utils.tables'
M.get_plugin_by_url = function(name)
    return tables.peek_find_eq(require 'lazy'.plugins(), 1, name)
end

M.get_plugin_by_name = function(name)
    return tables.map_peek_find_eq(require 'lazy'.plugins(), function(x)
        if type(x[1]) ~= 'string' then return '' end
        local split = vim.split(x[1], '/', {
            plain = true,
            trimempty = true,
        })
        return split[#split]
    end, name)
end

return M
