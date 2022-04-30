xplr.config.modes.builtin.number = {
    name = 'number',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            backspace = {
                help = 'remove last character',
                messages = { 'RemoveInputBufferLastCharacter' },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            ['ctrl-u'] = {
                help = 'remove line',
                messages = {
                    {
                        SetInputBuffer = '',
                    },
                },
            },
            ['ctrl-w'] = {
                help = 'remove last word',
                messages = { 'RemoveInputBufferLastWord' },
            },
            down = {
                help = 'to down',
                messages = { 'FocusNextByRelativeIndexFromInput', 'PopMode' },
            },
            enter = {
                help = 'to index',
                messages = { 'FocusByIndexFromInput', 'PopMode' },
            },
            esc = {
                help = 'cancel',
                messages = { 'PopMode' },
            },
            up = {
                help = 'to up',
                messages = { 'FocusPreviousByRelativeIndexFromInput', 'PopMode' },
            },
        },
        on_alphabet = nil,
        on_number = {
            help = 'input',
            messages = { 'UpdateInputBufferFromKey' },
        },
        on_special_character = nil,
        default = nil,
    },
}

xplr.config.modes.builtin.number.key_bindings.on_key['j'] = xplr.config.modes.builtin.number.key_bindings.on_key.down
xplr.config.modes.builtin.number.key_bindings.on_key['k'] = xplr.config.modes.builtin.number.key_bindings.on_key.up
