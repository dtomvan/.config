xplr.config.modes.builtin.go_to = {
    name = 'go to',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            esc = {
                help = 'cancel',
                messages = { 'PopMode' },
            },
            ['f'] = {
                help = 'follow symlink',
                messages = { 'FollowSymlink', 'PopMode' },
            },
            ['g'] = {
                help = 'top',
                messages = { 'FocusFirst', 'PopMode' },
            },
            ['x'] = {
                help = 'open in gui',
                messages = {
                    {
                        BashExec = [===[
                        devour xdg-open "${XPLR_FOCUS_PATH:?}" || xdg-open "${XPLR_FOCUS_PATH:?}"
                        ]===],
                    },
                    'PopMode',
                },
            },
        },
        on_alphabet = nil,
        on_number = nil,
        on_special_character = nil,
        default = nil,
    },
}
