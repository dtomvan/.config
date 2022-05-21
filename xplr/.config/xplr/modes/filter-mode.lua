-- The builtin filter mode.
--
-- Type: [Mode](https://xplr.dev/en/mode)
xplr.config.modes.builtin.filter = {
    name = 'filter',
    key_bindings = {
        on_key = {
            ['r'] = {
                help = 'relative path does match regex',
                messages = {
                    { SwitchModeBuiltin = 'relative_path_does_match_regex' },
                    {
                        SetInputPrompt = xplr.config.general.sort_and_filter_ui.filter_identifiers.RelativePathDoesMatchRegex.format,
                    },
                    { SetInputBuffer = '' },
                    { AddNodeFilterFromInput = 'RelativePathDoesMatchRegex' },
                    'ExplorePwdAsync',
                },
            },
            ['R'] = {
                help = 'relative path does not match regex',
                messages = {
                    { SwitchModeBuiltin = 'relative_path_does_not_match_regex' },
                    {
                        SetInputPrompt = xplr.config.general.sort_and_filter_ui.filter_identifiers.RelativePathDoesNotMatchRegex.format,
                    },
                    { SetInputBuffer = '' },
                    { AddNodeFilterFromInput = 'RelativePathDoesNotMatchRegex' },
                    'ExplorePwdAsync',
                },
            },
            enter = {
                help = 'done',
                messages = {
                    'PopMode',
                },
            },
            backspace = {
                help = 'remove last filter',
                messages = {
                    'RemoveLastNodeFilter',
                    'ExplorePwdAsync',
                },
            },
            ['ctrl-r'] = {
                help = 'reset filters',
                messages = {
                    'ResetNodeFilters',
                    'ExplorePwdAsync',
                },
            },
            ['ctrl-u'] = {
                help = 'clear filters',
                messages = {
                    'ClearNodeFilters',
                    'ExplorePwdAsync',
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

xplr.config.modes.builtin.filter.key_bindings.on_key['esc'] = xplr.config.modes.builtin.filter.key_bindings.on_key.enter
