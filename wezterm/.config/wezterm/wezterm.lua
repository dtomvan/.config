local wezterm = require 'wezterm'

local font = wezterm.font 'Iosevka Nerd Font'

function scheme_for_appearance(appearance)
    if appearance:find 'Dark' then
        return 'Catppuccin Mocha'
    else
        return 'Catppuccin Latte'
    end
end

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)

return {
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
    font = font,
    font_size = 13,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        { key = '9', mods = 'ALT', action = wezterm.action { ShowLauncherArgs = { flags = 'FUZZY|WORKSPACES' } } },
        { key = 'n', mods = 'ALT', action = wezterm.action { SwitchWorkspaceRelative = 1 } },
        { key = 'p', mods = 'ALT', action = wezterm.action { SwitchWorkspaceRelative = -1 } },
    },
    window_background_opacity = 1,
    check_for_updates = false,
}
