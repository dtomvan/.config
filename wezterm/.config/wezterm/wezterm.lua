local wezterm = require 'wezterm'

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
    font = wezterm.font_with_fallback {
        {
            stretch = 'Condensed',
            weight = 'Regular',
            family = 'Fira Code',
            harfbuzz_features = {
                'ccmp',
                'clig',
                'cv14',
                'cv16',
                'cv29',
                'cv30',
                'cv31',
                'salt',
                'ss03',
                'ss04',
            },
        },
        { family = 'Symbols Nerd Font Mono', scale = 0.9 },
    },
    font_size = 12,
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
