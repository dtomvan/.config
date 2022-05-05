xplr.config.modes.builtin.action = {
    name = 'action to',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ['t'] = {
                help = 'open tmux in pwd',
                messages = {
                    {
                        BashExec = [==[
                        NAME="$PWD-$(tr -dc a-z </dev/urandom | head -c 3)"
                        tmux has-session -t "$NAME"
                        if [ $? != 0 ]
                        then
                            tmux new-session -s "$NAME" -d
                        fi
                        tmux attach -t "$NAME" || tmux switch-client -t "$NAME"
                        ]==],
                    },
                    'PopMode',
                },
            },
            ['!'] = {
                help = 'shell',
                messages = {
                    {
                        Call = {
                            command = 'zsh',
                        },
                    },
                    'ExplorePwdAsync',
                    'PopMode',
                },
            },
            ['g'] = {
                help = 'git operations',
                messages = {
                    'PopMode',
                    {
                        SwitchModeCustom = 'git',
                    },
                },
            },
            ['p'] = {
                help = 'plugins',
                messages = {
                    'PopMode',
                    {
                        SwitchModeCustom = 'xpm',
                    },
                },
            },
            ['c'] = {
                help = 'create',
                messages = {
                    {
                        SwitchModeBuiltin = 'create',
                    },
                },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            ['e'] = {
                help = 'open in editor',
                messages = {
                    {
                        BashExec = [===[
                        ${EDITOR:-vi} "${XPLR_FOCUS_PATH:?}"
                        ]===],
                    },
                    'PopMode',
                },
            },
            ['x'] = {
                help = 'open in gui',
                messages = {
                    {
                        BashExec = [===[
                        xdg-open "${XPLR_FOCUS_PATH:?}"
                        ]===],
                    },
                    'PopMode',
                },
            },
            esc = {
                help = 'cancel',
                messages = { 'PopMode' },
            },
            ['l'] = {
                help = 'logs',
                messages = {
                    {
                        BashExec = [===[
                        [ -z "$PAGER" ] && PAGER="less -+F"
                        cat -- "${XPLR_PIPE_LOGS_OUT}" | ${PAGER:?}
                        ]===],
                    },
                    'PopMode',
                },
            },
            ['s'] = {
                help = 'selection operations',
                messages = {
                    'PopMode',
                    {
                        SwitchModeBuiltin = 'selection_ops',
                    },
                },
            },
            ['m'] = {
                help = 'toggle mouse',
                messages = {
                    'PopMode',
                    'ToggleMouse',
                },
            },
            ['q'] = {
                help = 'quit options',
                messages = {
                    'PopMode',
                    { SwitchModeBuiltin = 'quit' },
                },
            },
        },
        on_alphabet = nil,
        on_number = {
            help = 'go to index',
            messages = {
                'PopMode',
                {
                    SwitchModeBuiltin = 'number',
                },
                'UpdateInputBufferFromKey',
            },
        },
        on_special_character = nil,
        default = nil,
    },
}
