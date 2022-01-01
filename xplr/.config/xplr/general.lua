------ Cursor
-- Deprecated :(
-- xplr.config.general.cursor.format = "|"

------ Initial layout
xplr.config.general.initial_layout = "default"

------ Initial mode
xplr.config.general.initial_mode = "default"

------ Hide remaps in help menu
xplr.config.general.hide_remaps_in_help_menu = true

------ Initial sorting
xplr.config.general.initial_sorting = {
    { sorter = "ByCanonicalIsDir", reverse = true },
    { sorter = "ByIRelativePath", reverse = false },
}

------ Default UI
xplr.config.general.default_ui.prefix = " "
xplr.config.general.default_ui.suffix = ""

------ Focus UI
xplr.config.general.focus_ui.prefix = "▸"
xplr.config.general.focus_ui.suffix = ""
xplr.config.general.focus_ui.style.add_modifiers = { "Bold" }
xplr.config.general.focus_ui.style.fg = "Yellow"

------ Selection UI
xplr.config.general.selection_ui.prefix = " "
xplr.config.general.selection_ui.suffix = ""
xplr.config.general.selection_ui.style.add_modifiers = { "Bold" }
xplr.config.general.selection_ui.style.fg = "Green"

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

------ Panel UI
xplr.config.general.panel_ui.default.borders = {
    "Bottom",
}

xplr.fn.builtin.fmt_general_table_row_cols_1 = function(m)
    local icons = require("icons")
    local ext = m.relative_path:match("^.*%.(.*)$") or ""
    local icon = icons[m.relative_path] or icons[m.mime_essence] or icons[ext]

    if type(icon) == "string" then
        m.meta.icon = icon
    end

    local is_binary = m.permissions.user_execute
    or m.permissions.group_execute
    or m.permissions.other_execute

    if m.is_broken then
        -- Broken symlink icon is hardcoded. Not implemented in xplr yet.
        m.meta.icon = ""
    end

    if not m.is_broken and type(icon) ~= "string" and is_binary and m.canonical.is_file then
        m.meta.icon = icons["application/octet-stream"]
    end

    local r = m.tree .. m.prefix

    if m.meta.icon == nil then
        r = r .. ""
    else
        r = r .. m.meta.icon .. " "
    end

    r = r .. m.relative_path

    if m.is_dir then
        r = r .. "/"
    end

    r = r .. m.suffix .. " "

    if m.is_symlink then
        r = r .. "-> "

        if m.is_broken then
            r = r .. "×"
        else
            r = r .. m.symlink.absolute_path

            if m.symlink.is_dir then
                r = r .. "/"
            end
        end
    end

    return r
end
