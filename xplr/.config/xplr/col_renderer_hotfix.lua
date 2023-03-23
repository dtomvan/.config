xplr.fn.builtin.fmt_general_selection_item = function(n)
    local nl = xplr.util.paint("\\n", { add_modifiers = { "Italic", "Dim" } })
    local sh_config = { with_prefix_dots = true, without_suffix_dots = true }
    local shortened = xplr.util.shorten(n.absolute_path, sh_config)
    if n.is_dir then
        shortened = shortened .. "/"
    end
    local style = xplr.util.node_type(n).style
    return xplr.util.paint(shortened:gsub("\n", nl), style)
end

-- Renders the second column in the table
xplr.fn.builtin.fmt_general_table_row_cols_1 = function(m)
    local nl = xplr.util.paint("\\n", { add_modifiers = { "Italic", "Dim" } })
    local r = m.tree .. m.prefix

    if m.meta.icon == nil then
        r = r .. ""
    else
        r = r .. m.meta.icon .. " "
    end

    local rel = m.relative_path
    if m.is_dir then
        rel = rel .. "/"
    end
    r = r .. xplr.util.paint(xplr.util.shell_escape(rel), m.style)

    r = r .. m.suffix .. " "

    if m.is_symlink then
        r = r .. "-> "

        if m.is_broken then
            r = r .. "×"
        else
            local symlink_path = xplr.util.shorten(m.symlink.absolute_path)
            if m.symlink.is_dir then
                symlink_path = symlink_path .. "/"
            end
            r = r .. symlink_path:gsub("\n", nl)
        end
    end

    return r
end
