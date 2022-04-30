---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.
---@diagnostic enable

-- This is the built-in configuration file that gets loaded and sets the
-- default values when xplr loads, before loading any other custom
-- configuration file.
--
-- You can use this file as a reference to create a your custom config file.
--
-- To create a custom configuration file, you need to define the script version
-- for compatibility checks.
--
-- See https://xplr.dev/en/upgrade-guide
--
-- ```lua
-- version = "0.0.0"
-- ```

-- # Configuration ------------------------------------------------------------
--
-- xplr can be configured using [Lua][1] via a special file named `init.lua`,
-- which can be placed in `~/.config/xplr/` (local to user) or `/etc/xplr/`
-- (global) depending on the use case.
--
-- When xplr loads, it first executes the [built-in init.lua][2] to set the
-- default values, which is then overwritten by another config file, if found
-- using the following lookup order:
--
-- 1. `--config /path/to/init.lua`
-- 2. `~/.config/xplr/init.lua`
-- 3. `/etc/xplr/init.lua`
--
-- The first one found will be loaded by xplr and the lookup will stop.
--
-- The loaded config can be further extended using the `-C` or `--extra-config`
-- command-line option.
--
--
-- [1]: https://www.lua.org
-- [2]: https://github.com/sayanarijit/xplr/blob/main/src/init.lua
-- [3]: https://xplr.dev/en/upgrade-guide

-- ## Config ------------------------------------------------------------------
--
-- The xplr configuration, exposed via `xplr.config` Lua API contains the
-- following sections.
--
-- See:
--
-- * [xplr.config.general](https://xplr.dev/en/general-config)
-- * [xplr.config.node_types](https://xplr.dev/en/node_types)
-- * [xplr.config.layouts](https://xplr.dev/en/layouts)
-- * [xplr.config.modes](https://xplr.dev/en/modes)

-- ### General Configuration --------------------------------------------------
--
-- The general configuration properties are grouped together in
-- `xplr.config.general`.

-- Set it to `true` if you want to ignore the startup errors. You can still see
-- the errors in the logs.
--
-- Type: boolean
xplr.config.general.disable_debug_error_mode = false

-- Set it to `true` if you want to enable mouse scrolling.
--
-- Type: boolean
xplr.config.general.enable_mouse = false

-- Set it to `true` to show hidden files by default.
--
-- Type: boolean
xplr.config.general.show_hidden = false

-- Set it to `true` to use only a subset of selected operations that forbids
-- executing commands or performing write operations on the file-system.
--
-- Type: boolean
xplr.config.general.read_only = false

-- Set it to `true` if you want to enable a safety feature that will save you
-- from yourself when you type recklessly.
--
-- Type: boolean
xplr.config.general.enable_recover_mode = false

-- Set it to `true` if you want to hide all remaps in the help menu.
--
-- Type: boolean
xplr.config.general.hide_remaps_in_help_menu = false

-- Set it to `true` if you want the cursor to stay in the same position when
-- the focus is on the first path and you navigate to the previous path
-- (by pressing `up`/`k`), or when the focus is on the last path and you
-- navigate to the next path (by pressing `down`/`j`).
-- The default behavior is to rotate from the last/first path.
--
-- Type: boolean
xplr.config.general.enforce_bounded_index_navigation = false

-- This is the shape of the prompt for the input buffer.
--
-- Type: nullable string
xplr.config.general.prompt.format = '❯ '

-- This is the style of the prompt for the input buffer.
--
-- Type: [Style](https://xplr.dev/en/style)
xplr.config.general.prompt.style = {}

-- The string to indicate an information in logs.
--
-- Type: nullable string
xplr.config.general.logs.info.format = 'INFO'

-- The style for the informations logs.
--
-- Type: [Style](https://xplr.dev/en/style)
xplr.config.general.logs.info.style = { fg = 'LightBlue' }

-- The string to indicate an success in logs.
--
-- Type: nullable string
xplr.config.general.logs.success.format = 'SUCCESS'

-- The style for the success logs.
--
-- Type: [Style](https://xplr.dev/en/style)
xplr.config.general.logs.success.style = { fg = 'Green' }

-- The string to indicate an warnings in logs.
--
-- Type: nullable string
xplr.config.general.logs.warning.format = 'WARNING'

-- The style for the warnings logs.
--
-- Type: [Style](https://xplr.dev/en/style)
xplr.config.general.logs.warning.style = { fg = 'Yellow' }

-- The string to indicate an error in logs.
--
-- Type: nullable string
xplr.config.general.logs.error.format = 'ERROR'

-- The style for the error logs.
--
-- Type: [Style](https://xplr.dev/en/style)
xplr.config.general.logs.error.style = { fg = 'Red' }

-- Columns to display in the table header.
--
-- Type: nullable list of tables with the following fields:
--
-- * format: nullable string
-- * style: [Style](https://xplr.dev/en/style)
xplr.config.general.table.header.cols = {
    { format = ' index', style = {} },
    { format = '╭──── path', style = {} },
    { format = 'permissions', style = {} },
    { format = 'size', style = {} },
    { format = 'type', style = {} },
}

-- Style of the table header.
--
-- Type: [Style](https://xplr.dev/en/style)
xplr.config.general.table.header.style = {}

-- Height of the table header.
--
-- Type: nullable integer
xplr.config.general.table.header.height = 1

-- Columns to display in each row in the table.
--
-- Type: nullable list of tables with the following fields:
--
-- * format: nullable string
-- * style: [Style](https://xplr.dev/en/style)
xplr.config.general.table.row.cols = {
    {
        format = 'builtin.fmt_general_table_row_cols_0',
        style = {},
    },
    {
        format = 'builtin.fmt_general_table_row_cols_1',
        style = {},
    },
    {
        format = 'builtin.fmt_general_table_row_cols_2',
        style = {},
    },
    {
        format = 'builtin.fmt_general_table_row_cols_3',
        style = {},
    },
    {
        format = 'builtin.fmt_general_table_row_cols_4',
        style = {},
    },
}

-- Default style of the table.
--
-- Type: [Style](https://xplr.dev/en/style)
xplr.config.general.table.row.style = {}

-- Height of the table rows.
--
-- Type: nullable integer
xplr.config.general.table.row.height = 0

-- Default style of the table.
--
-- Type: [Style](https://xplr.dev/en/style)
xplr.config.general.table.style = {}

------ Initial mode
xplr.config.general.initial_mode = 'default'

------ Hide remaps in help menu
xplr.config.general.hide_remaps_in_help_menu = true

------ Initial sorting
xplr.config.general.initial_sorting = {
    { sorter = 'ByCanonicalIsDir', reverse = true },
    { sorter = 'ByIRelativePath', reverse = false },
}

------ Default UI
xplr.config.general.default_ui.prefix = ' '
xplr.config.general.default_ui.suffix = ''

------ Focus UI
xplr.config.general.focus_ui.prefix = '▸'
xplr.config.general.focus_ui.suffix = ''
xplr.config.general.focus_ui.style.add_modifiers = { 'Bold' }
xplr.config.general.focus_ui.style.fg = 'Yellow'

------ Selection UI
xplr.config.general.selection_ui.prefix = ' '
xplr.config.general.selection_ui.suffix = ''
xplr.config.general.selection_ui.style.add_modifiers = { 'Bold' }
xplr.config.general.selection_ui.style.fg = 'Green'

------ Sort & filter UI
-------- Separator
xplr.config.general.sort_and_filter_ui.separator.format = ' › '
xplr.config.general.sort_and_filter_ui.separator.style.add_modifiers = { 'Dim' }

-------- Default identidier
xplr.config.general.sort_and_filter_ui.default_identifier.style = {}

-------- Col spacing
xplr.config.general.table.col_spacing = 1

-------- Col widths
xplr.config.general.table.col_widths = {
    { Percentage = 10 },
    { Percentage = 50 },
    { Percentage = 10 },
    { Percentage = 10 },
    { Percentage = 20 },
}

-------- Tree
xplr.config.general.table.tree = {
    { format = '├─', style = { add_modifiers = nil, bg = nil, fg = nil, sub_modifiers = nil } },
    { format = '├─', style = { add_modifiers = nil, bg = nil, fg = nil, sub_modifiers = nil } },
    { format = '╰─', style = { add_modifiers = nil, bg = nil, fg = nil, sub_modifiers = nil } },
}

---- Node types
------ Directory
xplr.config.node_types.directory.meta.icon = ''
xplr.config.node_types.directory.style.add_modifiers = { 'Bold' }
xplr.config.node_types.directory.style.fg = 'Cyan'

------ File
xplr.config.node_types.file.meta.icon = ''

------ Symlink
xplr.config.node_types.symlink.meta.icon = '§'
xplr.config.node_types.symlink.style.add_modifiers = { 'Italic' }
xplr.config.node_types.symlink.style.fg = 'Magenta'

------ Panel UI
xplr.config.general.panel_ui.default.title.style = {
    fg = 'Reset',
    add_modifiers = { 'Bold' },
}

xplr.config.general.panel_ui.default.borders = {
    'Bottom',
}

xplr.fn.builtin.fmt_general_table_row_cols_0 = function(m)
    local index = ' ' .. m.relative_index
    if m.is_focused then
        index = m.index
    end

    return '  ' .. index
end
