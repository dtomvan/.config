local wezterm = require 'wezterm'

local font = wezterm.font 'Iosevka Nerd Font'

-- Kanagawa
local colors = {
    foreground = 'silver',
    background = '#1F1F28',
    cursor_bg = '#C8C093',
    cursor_fg = 'black',
    cursor_border = '#C8C093',
    selection_bg = '#2D4F67',
    selection_fg = 'rgba(0,0,0,0)',
    scrollbar_thumb = '#222222',
    split = '#444444',
    ansi = {
        '#090618',
        '#C34043',
        '#76946A',
        '#C0A36E',
        '#7E9CD8',
        '#957FB8',
        '#6A9589',
        '#C8C093',
    },
    brights = {
        '#727169',
        '#E82424',
        '#98BB6C',
        '#E6C384',
        '#7FB4CA',
        '#938AA9',
        '#7AA89F',
        '#DCD7BA',
    },
    indexed = { [136] = '#af8700' },
    compose_cursor = 'orange',
}

local tab_bar = {
    background = colors.background,
}
colors.tab_bar = tab_bar

wezterm.on("update-right-status", function(window, pane)
  window:set_right_status(window:active_workspace())
end)

return {
    colors = colors,
    font = font,
    font_size = 13,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        {key="9", mods="ALT", action=wezterm.action{ShowLauncherArgs={flags="FUZZY|WORKSPACES"}}},
        {key="n", mods="ALT", action=wezterm.action{SwitchWorkspaceRelative=1}},
        {key="p", mods="ALT", action=wezterm.action{SwitchWorkspaceRelative=-1}},
    },
    window_background_opacity = 1,
    check_for_updates = false,
}
