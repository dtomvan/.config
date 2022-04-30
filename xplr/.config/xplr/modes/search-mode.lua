xplr.config.modes.builtin.search = {
    name = 'search',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            backspace = {
                help = 'remove last character',
                messages = {
                    {
                        RemoveNodeFilterFromInput = 'IRelativePathDoesContain',
                    },
                    'RemoveInputBufferLastCharacter',
                    {
                        AddNodeFilterFromInput = 'IRelativePathDoesContain',
                    },
                    'ExplorePwdAsync',
                },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            ['ctrl-u'] = {
                help = 'remove line',
                messages = {
                    {
                        RemoveNodeFilterFromInput = 'IRelativePathDoesContain',
                    },
                    {
                        SetInputBuffer = '',
                    },
                    {
                        AddNodeFilterFromInput = 'IRelativePathDoesContain',
                    },
                    'ExplorePwdAsync',
                },
            },
            ['ctrl-w'] = {
                help = 'remove last word',
                messages = {
                    {
                        RemoveNodeFilterFromInput = 'IRelativePathDoesContain',
                    },
                    'RemoveInputBufferLastWord',
                    {
                        AddNodeFilterFromInput = 'IRelativePathDoesContain',
                    },
                    'ExplorePwdAsync',
                },
            },
            down = {
                help = 'down',
                messages = { 'FocusNext' },
            },
            enter = {
                help = 'focus',
                messages = {
                    {
                        RemoveNodeFilterFromInput = 'IRelativePathDoesContain',
                    },
                    'PopMode',
                    'ExplorePwdAsync',
                },
            },
            left = {
                help = 'back',
                messages = {
                    {
                        RemoveNodeFilterFromInput = 'IRelativePathDoesContain',
                    },
                    'Back',
                    {
                        SetInputBuffer = '',
                    },
                    'ExplorePwdAsync',
                },
            },
            right = {
                help = 'enter',
                messages = {
                    {
                        RemoveNodeFilterFromInput = 'IRelativePathDoesContain',
                    },
                    'Enter',
                    {
                        SetInputBuffer = '',
                    },
                    'ExplorePwdAsync',
                },
            },
            tab = {
                help = 'toggle selection',
                messages = { 'ToggleSelection', 'FocusNext' },
            },
            up = {
                help = 'up',
                messages = { 'FocusPrevious' },
            },
        },
        on_alphabet = nil,
        on_number = nil,
        on_special_character = nil,
        default = {
            help = nil,
            messages = {
                {
                    RemoveNodeFilterFromInput = 'IRelativePathDoesContain',
                },
                'UpdateInputBufferFromKey',
                {
                    AddNodeFilterFromInput = 'IRelativePathDoesContain',
                },
                'ExplorePwdAsync',
            },
        },
    },
}

xplr.config.modes.builtin.search.key_bindings.on_key['esc'] = xplr.config.modes.builtin.search.key_bindings.on_key.enter
xplr.config.modes.builtin.search.key_bindings.on_key['ctrl-n'] =
    xplr.config.modes.builtin.search.key_bindings.on_key.down
xplr.config.modes.builtin.search.key_bindings.on_key['ctrl-p'] = xplr.config.modes.builtin.search.key_bindings.on_key.up
