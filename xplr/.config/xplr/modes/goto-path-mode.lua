-- From https://github.com/sayanarijit/.files/blob/6663084b97d3283475ecef25fcafd0bea142ab23/nixpkgs/files/xplr/init.lua#L85
xplr.config.modes.builtin.go_to.key_bindings.on_key.p = {
    help = 'go to path',
    messages = {
        'PopMode',
        { SwitchModeCustom = 'go_to_path' },
        { SetInputBuffer = '' },
    },
}

xplr.config.modes.custom.go_to_path = {
    name = 'go to path',
    key_bindings = {
        on_key = {
            enter = {
                messages = {
                    'FocusPathFromInput',
                    'PopMode',
                },
            },
            esc = {
                help = 'cancel',
                messages = { 'PopMode' },
            },
            tab = {
                help = 'complete',
                messages = {
                    { CallLuaSilently = 'custom.completion.complete_path' },
                },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            backspace = {
                help = 'remove last character',
                messages = { 'RemoveInputBufferLastCharacter' },
            },
            ['ctrl-u'] = {
                help = 'remove line',
                messages = { { SetInputBuffer = '' } },
            },
            ['ctrl-w'] = {
                help = 'remove last word',
                messages = { 'RemoveInputBufferLastWord' },
            },
        },
        default = {
            messages = {
                'UpdateInputBufferFromKey',
            },
        },
    },
}
