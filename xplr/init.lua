version = "0.14.3"

package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'
package.path = package.path .. ";" .. os.getenv("HOME") .. '/.config/xplr/?.lua'

-- Config
---- General
require('general')
-- Layouts
require('layouts')
-- Modes
require('modes')
-- Function
---- Builtin
------ Formatters
-------- Format index column
xplr.fn.builtin.fmt_general_table_row_cols_0 = function(m)
  local r = ""
  if m.is_before_focus then
    r = r .. " -"
  else
    r = r .. "  "
  end

  r = r .. m.relative_index .. "│" .. m.index

  return r
end

-------- Format path column
xplr.fn.builtin.fmt_general_table_row_cols_1 = function(m)
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

-------- Format permissions column
xplr.fn.builtin.fmt_general_table_row_cols_2 = function(m)

  local no_color = os.getenv("NO_COLOR")

  local function green(x)
    if no_color == nil then
      return "\x1b[32m" .. x .. "\x1b[0m"
    else
      return x
    end
  end

  local function yellow(x)
    if no_color == nil then
      return "\x1b[33m" .. x .. "\x1b[0m"
    else
      return x
    end
  end


  local function red(x)
    if no_color == nil then
      return "\x1b[31m" .. x .. "\x1b[0m"
    else
      return x
    end
  end

  local function bit(x, color, cond)
    if cond then
      return color(x)
    else
      return color("-")
    end
  end

  local p = m.permissions

  local r = ""

  -- User
  r = r .. bit("r", green, p.user_read)
  r = r .. bit("w", yellow, p.user_write)

  if p.user_execute == false and p.setuid == false then
    r = r .. bit("-", red, p.user_execute)
  elseif p.user_execute == true and p.setuid == false then
    r = r .. bit("x", red, p.user_execute)
  elseif p.user_execute == false and p.setuid == true then
    r = r .. bit("S", red, p.user_execute)
  else
    r = r .. bit("s", red, p.user_execute)
  end

  -- Group
  r = r .. bit("r", green, p.group_read)
  r = r .. bit("w", yellow, p.group_write)

  if p.group_execute == false and p.setuid == false then
    r = r .. bit("-", red, p.group_execute)
  elseif p.group_execute == true and p.setuid == false then
    r = r .. bit("x", red, p.group_execute)
  elseif p.group_execute == false and p.setuid == true then
    r = r .. bit("S", red, p.group_execute)
  else
    r = r .. bit("s", red, p.group_execute)
  end

  -- Other
  r = r .. bit("r", green, p.other_read)
  r = r .. bit("w", yellow, p.other_write)

  if p.other_execute == false and p.setuid == false then
    r = r .. bit("-", red, p.other_execute)
  elseif p.other_execute == true and p.setuid == false then
    r = r .. bit("x", red, p.other_execute)
  elseif p.other_execute == false and p.setuid == true then
    r = r .. bit("S", red, p.other_execute)
  else
    r = r .. bit("s", red, p.other_execute)
  end

  return r
end

-------- Format size column
xplr.fn.builtin.fmt_general_table_row_cols_3 = function(m)
  if not m.is_dir then
    return m.human_size
  else
    return ""
  end
end

-------- Format mime column
xplr.fn.builtin.fmt_general_table_row_cols_4 = function(m)
  if m.is_symlink and not m.is_broken then
    return m.symlink.mime_essence
  else
    return m.mime_essence
  end
end

---- Custom
xplr.fn.custom = {}
require("fzf").setup()
require("xargs").setup()
