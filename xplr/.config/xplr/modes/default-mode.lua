xplr.config.modes.builtin.default = {
    name = 'default',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ['#'] = {
                help = nil,
                messages = { 'PrintAppStateAndQuit' },
            },
            ['.'] = {
                help = 'show hidden',
                messages = {
                    {
                        ToggleNodeFilter = {
                            filter = 'RelativePathDoesNotStartWith',
                            input = '.',
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            [':'] = {
                help = 'action',
                messages = {
                    'PopMode',
                    {
                        SwitchModeBuiltin = 'action',
                    },
                },
            },
            ['?'] = {
                help = 'global help menu',
                messages = {
                    {
                        BashExec = [===[
                        [ -z "$PAGER" ] && PAGER="less -+F"
                        cat -- "${XPLR_PIPE_GLOBAL_HELP_MENU_OUT}" | ${PAGER:?}
                        ]===],
                    },
                },
            },
            ['G'] = {
                help = 'go to bottom',
                messages = { 'PopMode', 'FocusLast' },
            },
            ['ctrl-a'] = {
                help = 'select/unselect all',
                messages = { 'ToggleSelectAll' },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            ['ctrl-f'] = {
                help = 'search',
                messages = {
                    'PopMode',
                    { SwitchModeBuiltin = 'search' },
                    { SetInputBuffer = '' },
                    'ExplorePwdAsync',
                },
            },
            ['ctrl-i'] = {
                help = 'next visited path',
                messages = { 'NextVisitedPath' },
            },
            ['ctrl-o'] = {
                help = 'last visited path',
                messages = { 'LastVisitedPath' },
            },
            ['ctrl-r'] = {
                help = 'refresh screen',
                messages = { 'ClearScreen' },
            },
            ['ctrl-u'] = {
                help = 'clear selection',
                messages = { 'ClearSelection' },
            },
            ['ctrl-w'] = {
                help = 'switch layout',
                messages = {
                    {
                        SwitchModeBuiltin = 'switch_layout',
                    },
                },
            },
            ['d'] = {
                help = 'delete',
                messages = {
                    'PopMode',
                    {
                        SwitchModeBuiltin = 'delete',
                    },
                },
            },
            down = {
                help = 'down',
                messages = { 'FocusNext' },
            },
            enter = {
                help = 'quit with result',
                messages = { 'PrintResultAndQuit' },
            },
            esc = {
                help = nil,
                messages = {},
            },
            ['f'] = {
                help = 'filter',
                messages = {
                    'PopMode',
                    { SwitchModeBuiltin = 'filter' },
                },
            },
            ['g'] = {
                help = 'go to',
                messages = {
                    'PopMode',
                    { SwitchModeBuiltin = 'go_to' },
                },
            },
            left = {
                help = 'back',
                messages = { 'Back' },
            },
            ['q'] = {
                help = 'quit',
                messages = { 'Quit' },
            },
            ['r'] = {
                help = 'rename',
                messages = {
                    'PopMode',
                    { SwitchModeBuiltin = 'rename' },
                    {
                        BashExecSilently = [===[
                        echo SetInputBuffer: "'"$(basename "${XPLR_FOCUS_PATH}")"'" >> "${XPLR_PIPE_MSG_IN:?}"
                        ]===],
                    },
                },
            },
            right = {
                help = 'enter',
                messages = { 'Enter' },
            },
            ['s'] = {
                help = 'sort',
                messages = {
                    'PopMode',
                    { SwitchModeBuiltin = 'sort' },
                },
            },
            space = {
                help = 'toggle selection',
                messages = { 'ToggleSelection', 'FocusNext' },
            },
            up = {
                help = 'up',
                messages = { 'FocusPrevious' },
            },
            ['~'] = {
                help = 'go home',
                messages = {
                    {
                        BashExecSilently = [===[
                        echo ChangeDirectory: "'"${HOME:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
                        ]===],
                    },
                },
            },
        },
        on_alphabet = nil,
        on_number = {
            help = 'input',
            messages = {
                'PopMode',
                { SwitchModeBuiltin = 'number' },
                'UpdateInputBufferFromKey',
            },
        },
        on_special_character = nil,
        default = {
            messages = {
                'PopMode',
                { SwitchModeBuiltin = 'recover' },
            },
        },
    },
}

xplr.config.modes.builtin.default.key_bindings.on_key['tab'] =
    xplr.config.modes.builtin.default.key_bindings.on_key['ctrl-i']
xplr.config.modes.builtin.default.key_bindings.on_key['v'] = xplr.config.modes.builtin.default.key_bindings.on_key.space
xplr.config.modes.builtin.default.key_bindings.on_key['V'] =
    xplr.config.modes.builtin.default.key_bindings.on_key['ctrl-a']
xplr.config.modes.builtin.default.key_bindings.on_key['/'] =
    xplr.config.modes.builtin.default.key_bindings.on_key['ctrl-f']
xplr.config.modes.builtin.default.key_bindings.on_key['h'] = xplr.config.modes.builtin.default.key_bindings.on_key.left
xplr.config.modes.builtin.default.key_bindings.on_key['j'] = xplr.config.modes.builtin.default.key_bindings.on_key.down
xplr.config.modes.builtin.default.key_bindings.on_key['k'] = xplr.config.modes.builtin.default.key_bindings.on_key.up
xplr.config.modes.builtin.default.key_bindings.on_key['l'] = xplr.config.modes.builtin.default.key_bindings.on_key.right
