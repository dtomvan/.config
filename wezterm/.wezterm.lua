local wezterm = require 'wezterm'
local act = wezterm.action

local directions = {
    h = "Left",
    j = "Down",
    k = "Up",
    l = "Right",
}

local insert = function(self, k, v)
    if not not v then
        table.insert(self, k, v)
    else
        table.insert(self, k)
    end
end

local mode = function(name)
    return act.ActivateKeyTable { name = name, one_shot = false, until_unknown = true }
end

local escape_act = { key = 'Escape', action = act.PopKeyTable }

local M = wezterm.config_builder()
M:set_strict_mode(true)

local scheme = "Catppuccin Mocha"
M.color_scheme = scheme

local cs = wezterm.get_builtin_color_schemes()[scheme]
local bg = wezterm.color.parse(cs.background)


M.window_background_gradient = {
    colors = {
        bg:lighten_fixed(0.1):adjust_hue_fixed(20):saturate(0.3),
        bg:adjust_hue_fixed(340)
    },
    orientation = { Radial = {
        cx = 0.75,
        cy = 0.75,
        radius = 0.4,
    } },
}

M.font = wezterm.font_with_fallback {
    'Iosevka Term',
    'Symbols Nerd Font Mono',
}
M.font_size = 16

M.window_decorations = 'NONE'
M.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
M.audible_bell = 'Disabled'

M.use_fancy_tab_bar = false

wezterm.on('update-status', function(window, _)
    window:set_left_status(wezterm.strftime ' [%d %b %H:%M] ')
end)
wezterm.on('update-right-status', function(window, pane)
    local leader = window:leader_is_active() and 'LEADER' or ''
    local name = window:active_key_table()
    name = name and ('m: ' .. name) or ''
    local b = wezterm.battery_info()[1]
    local level = string.format('%.0f%%', b.state_of_charge * 100)
    local ttl = b.time_to_full or b.time_to_empty
    if ttl then
        ttl = tonumber(ttl)
        ttl = string.format("%0.2fh", ttl / 3600)
    end

    window:set_right_status(("%s %s %s %s"):format(leader, name, level, ttl))
end)

M.leader = { key = 'a', mods = 'CTRL' }

k = {}
k.insert = insert
function leader(key, action, opts)
    opts = opts or {}
    local t = {}
    for k, v in pairs(opts) do
        t[k] = v
    end
    t.key = key
    t.action = action
    if t.mods then
        t.mods = 'LEADER|' .. t.mods
    else
        t.mods = 'LEADER'
    end

    k:insert(t)
end

for key, dir in pairs(directions) do
    leader(key, act.ActivatePaneDirection(dir))
end

for i = 1, 8 do
    leader(tostring(i), act.ActivateTab(i-1))
end

leader('c', act.SpawnTab 'CurrentPaneDomain')
leader('p', act.ActivateTabRelative(-1))
leader('n', act.ActivateTabRelative(1))
leader('o', act.ActivatePaneDirection 'Next')
leader('x', act.CloseCurrentTab { confirm = true })
leader('|', act.SplitHorizontal, { mods = 'SHIFT' })
leader('-', act.SplitVertical)
-- leader(':', act.ActivateCommandPalette, { mods = 'SHIFT' })
leader(':', act.ShowLauncher, { mods = 'SHIFT' })
leader('$', act.ShowTabNavigator, { mods = 'SHIFT' })
leader('[', act.ActivateCopyMode)
leader(']', act.QuickSelect)
leader('z', act.TogglePaneZoomState)

leader('!', act.PromptInputLine {
    description = 'launch command in tab...',
    -- Yazi alias, wait for stable release
    -- initial_value = 'zsh -i -c y'
    action = wezterm.action_callback(function(window, pane, command)
        window:perform_action(act.SpawnCommandInNewTab {
            args = wezterm.shell_split(command),
        }, pane)
    end),
}, { mods = 'SHIFT' })

leader('r', mode 'resize')
leader('a', mode 'activate')

k.insert = nil
M.keys = k

kt = {}
kt.insert = insert

local resize = {}
local activate = {}
for key, dir in pairs(directions) do
    table.insert(resize, {
        key = key,
        action = act.AdjustPaneSize { dir, 1 },
    })
    table.insert(activate, {
        key = key,
        action = act.ActivatePaneDirection(dir),
    })
end
table.insert(resize, escape_act)
table.insert(activate, escape_act)
kt.resize = resize
kt.activate = activate

kt.insert = nil

local copy_mode = nil
local search_mode = nil
if wezterm.gui then
    copy_mode = wezterm.gui.default_key_tables().copy_mode
    search_mode = wezterm.gui.default_key_tables().search_mode

    table.insert(copy_mode, { key = '/', mods = 'NONE', action = act.CopyMode 'EditPattern' })
    table.insert(copy_mode, { key = 'n', mods = 'NONE', action = act.CopyMode 'NextMatch' })
    table.insert(copy_mode, { key = 'N', mods = 'NONE', action = act.CopyMode 'PriorMatch' })

    table.insert(search_mode, { key = 'Space', mods = 'CTRL', action = act.CopyMode "AcceptPattern" })

    kt.copy_mode = copy_mode
    kt.search_mode = search_mode
end

M.key_tables = kt

M.mouse_wheel_scrolls_tabs = false
M.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = 'NONE',
        action = act.ScrollByLine(-1),
    },
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = 'NONE',
        action = act.ScrollByLine(1),
    },
}

local f = io.popen "/bin/hostname"
local hostname = f:read "*a" or ""
f:close()
if hostname == 'tom-laptop' then
    M.front_end = 'Software'
end

wezterm.plugin.require("https://gitlab.com/xarvex/presentation.wez").apply_to_config(M)

return M
-- vim:sw=4 ts=4
