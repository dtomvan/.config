xplr.config.modes.builtin.quit = {
    name = 'quit',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            enter = {
                help = 'just quit',
                messages = {
                    'Quit',
                },
            },
            p = {
                help = 'quit printing pwd',
                messages = {
                    'PrintPwdAndQuit',
                },
            },
            f = {
                help = 'quit printing focus',
                messages = {
                    'PrintFocusPathAndQuit',
                },
            },
            s = {
                help = 'quit printing selection',
                messages = {
                    'PrintSelectionAndQuit',
                },
            },
            r = {
                help = 'quit printing result',
                messages = {
                    'PrintResultAndQuit',
                },
            },
            esc = {
                help = 'cancel',
                messages = {
                    'PopMode',
                },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = {
                    'Terminate',
                },
            },
        },
    },
}
