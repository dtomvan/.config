local tables = require 'dtomvan.utils.tables'
local overseer = require 'overseer'
local tmpl_shell = require 'overseer.template.shell'

return overseer.wrap_template(tmpl_shell, {
    name = 'shell watch',
    builder = function(params)
        params.components = params.components or {}
        vim.list_extend(params.components, {
            'restart_on_save',
            {
                "on_output_quickfix",
                open = true,
                open_height = 8,
            },
            'default',
        })
        tables.map_peek_filter_not_eq(params.components, function(component)
            if type(component) == 'string' then
                return component
            elseif type(component) == 'table' then
                return component[1] or ""
            else
                return ""
            end
        end, 'on_complete_dispose')
        return tmpl_shell.builder(params)
    end,
})
