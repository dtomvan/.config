xplr.config.modes.builtin.switch_layout = {
    name = 'switch layout',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ['1'] = {
                help = 'default',
                messages = {
                    {
                        SwitchLayoutBuiltin = 'default',
                    },
                    'PopMode',
                },
            },
            ['2'] = {
                help = 'no help menu',
                messages = {
                    {
                        SwitchLayoutBuiltin = 'no_help',
                    },
                    'PopMode',
                },
            },
            ['3'] = {
                help = 'no selection panel',
                messages = {
                    {
                        SwitchLayoutBuiltin = 'no_selection',
                    },
                    'PopMode',
                },
            },
            ['4'] = {
                help = 'no help or selection',
                messages = {
                    {
                        SwitchLayoutBuiltin = 'no_help_no_selection',
                    },
                    'PopMode',
                },
            },
            ['5'] = {
                help = 'Logs Only',
                messages = {
                    {
                        SwitchLayoutCustom = 'logs_only',
                    },
                    'PopMode',
                },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            esc = {
                help = 'cancel',
                messages = { 'PopMode' },
            },
        },
        on_alphabet = nil,
        on_number = nil,
        on_special_character = nil,
        default = nil,
    },
}
