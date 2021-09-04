------ Show hidden
xplr.config.general.show_hidden = true

------ Read only
xplr.config.general.read_only = false

------ Recover mode
xplr.config.general.disable_recover_mode = false

------ Start FIFO
xplr.config.general.start_fifo = nil

------ Prompt
xplr.config.general.prompt.format = "❯ "

------ Cursor
xplr.config.general.cursor.format = "|"

------ Initial layout
xplr.config.general.initial_layout = "default"

------ Initial mode
xplr.config.general.initial_mode = "default"

------ Initial sorting
xplr.config.general.initial_sorting = {
    { sorter = "ByCanonicalIsDir", reverse = true },
    { sorter = "ByIRelativePath", reverse = false },
}

------ Logs
-------- Error
xplr.config.general.logs.error.format = "ERROR"
xplr.config.general.logs.error.style.fg = "Red"

-------- Info
xplr.config.general.logs.info.format = "INFO"
xplr.config.general.logs.info.style.fg = "LightBlue"

-------- Success
xplr.config.general.logs.success.format = "SUCCESS"
xplr.config.general.logs.success.style.fg = "Green"

-------- Warning
xplr.config.general.logs.warning.format = "WARNING"
xplr.config.general.logs.warning.style.fg = "Yellow"

------ Default UI
xplr.config.general.default_ui.prefix = "  "
xplr.config.general.default_ui.suffix = ""

------ Focus UI
xplr.config.general.focus_ui.prefix = "▸["
xplr.config.general.focus_ui.suffix = "]"
xplr.config.general.focus_ui.style.add_modifiers = { "Bold" }
xplr.config.general.focus_ui.style.fg = "Blue"

------ Selection UI
xplr.config.general.selection_ui.prefix = " {"
xplr.config.general.selection_ui.suffix = "}"
xplr.config.general.selection_ui.style.add_modifiers = { "Bold" }
xplr.config.general.selection_ui.style.fg = "LightGreen"

------ Sort & filter UI
-------- Separator
xplr.config.general.sort_and_filter_ui.separator.format = " › "
xplr.config.general.sort_and_filter_ui.separator.style.add_modifiers = { "Dim" }

-------- Default identidier
xplr.config.general.sort_and_filter_ui.default_identifier.style.add_modifiers = { "Bold" }

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
    { format = "├─", style = { add_modifiers = nil, bg = nil, fg = nil, sub_modifiers = nil } },
    { format = "├─", style = { add_modifiers = nil, bg = nil, fg = nil, sub_modifiers = nil } },
    { format = "╰─", style = { add_modifiers = nil, bg = nil, fg = nil, sub_modifiers = nil } },
}

---- Node types
------ Directory
xplr.config.node_types.directory.meta.icon = ""
xplr.config.node_types.directory.style.add_modifiers = { "Bold" }
xplr.config.node_types.directory.style.fg = "Cyan"

------ File
xplr.config.node_types.file.meta.icon = ""

------ Symlink
xplr.config.node_types.symlink.meta.icon = "§"
xplr.config.node_types.symlink.style.add_modifiers = { "Italic" }
xplr.config.node_types.symlink.style.fg = "Magenta"

------ Mime essence
xplr.config.node_types.mime_essence = {}

------ Extension
xplr.config.node_types.extension = {}

------ Special
xplr.config.node_types.special = {}
