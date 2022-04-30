xplr.config.modes.builtin.recover = {
    name = 'recover',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            esc = {
                help = 'escape',
                messages = { 'PopMode' },
            },
        },
        on_alphabet = nil,
        on_number = nil,
        on_special_character = nil,
        default = {
            help = nil,
            messages = {},
        },
    },
}
