-- The builtin relative_path_does_match_regex mode.
--
-- Type: [Mode](https://xplr.dev/en/mode)
xplr.config.modes.builtin.relative_path_does_match_regex = {
    name = 'relative path does match regex',
    key_bindings = {
        on_key = {
            ['ctrl-c'] = {
                help = 'terminate',
                messages = {
                    'Terminate',
                },
            },
            enter = {
                help = 'apply filter',
                messages = {
                    'PopMode',
                },
            },
            esc = {
                help = 'cancel',
                messages = {
                    { RemoveNodeFilterFromInput = 'RelativePathDoesMatchRegex' },
                    'PopMode',
                    'ExplorePwdAsync',
                },
            },
        },
        default = {
            messages = {
                { RemoveNodeFilterFromInput = 'RelativePathDoesMatchRegex' },
                'UpdateInputBufferFromKey',
                { AddNodeFilterFromInput = 'RelativePathDoesMatchRegex' },
                'ExplorePwdAsync',
            },
        },
    },
}
