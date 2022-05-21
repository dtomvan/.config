-- The builtin relative_path_does_not_match_regex mode.
--
-- Type: [Mode](https://xplr.dev/en/mode)
xplr.config.modes.builtin.relative_path_does_not_match_regex = {
    name = 'relative path does not match regex',
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
                    { RemoveNodeFilterFromInput = 'RelativePathDoesNotMatchRegex' },
                    'PopMode',
                    'ExplorePwdAsync',
                },
            },
        },
        default = {
            messages = {
                { RemoveNodeFilterFromInput = 'RelativePathDoesNotMatchRegex' },
                'UpdateInputBufferFromKey',
                { AddNodeFilterFromInput = 'RelativePathDoesNotMatchRegex' },
                'ExplorePwdAsync',
            },
        },
    },
}
