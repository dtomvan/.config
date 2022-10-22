xplr.config.modes.builtin.create = {
    name = 'create',
    key_bindings = {
        on_key = {
            ['d'] = {
                help = 'create directory',
                messages = {
                    'PopMode',
                    { SwitchModeBuiltin = 'create_directory' },
                    { SetInputBuffer = '' },
                },
            },
            ['f'] = {
                help = 'create file',
                messages = {
                    'PopMode',
                    { SwitchModeBuiltin = 'create_file' },
                    { SetInputBuffer = '' },
                },
            },
        },
    },
}
