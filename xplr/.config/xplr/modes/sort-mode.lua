xplr.config.modes.builtin.sort = {
    name = 'sort',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ['!'] = {
                help = 'reverse sorters',
                messages = { 'ReverseNodeSorters', 'ExplorePwdAsync' },
            },
            ['E'] = {
                help = 'by canonical extension reverse',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'ByCanonicalExtension',
                            reverse = true,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            ['M'] = {
                help = 'by canonical mime essence reverse',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'ByCanonicalMimeEssence',
                            reverse = true,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            ['N'] = {
                help = 'by node type reverse',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'ByCanonicalIsDir',
                            reverse = true,
                        },
                    },
                    {
                        AddNodeSorter = {
                            sorter = 'ByCanonicalIsFile',
                            reverse = true,
                        },
                    },
                    {
                        AddNodeSorter = {
                            sorter = 'ByIsSymlink',
                            reverse = true,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            ['R'] = {
                help = 'by relative path reverse',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'ByIRelativePath',
                            reverse = true,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            ['S'] = {
                help = 'by size reverse',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'BySize',
                            reverse = true,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            backspace = {
                help = 'remove last sorter',
                messages = { 'RemoveLastNodeSorter', 'ExplorePwdAsync' },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            ['ctrl-r'] = {
                help = 'reset sorters',
                messages = { 'ResetNodeSorters', 'ExplorePwdAsync' },
            },
            ['ctrl-u'] = {
                help = 'clear sorters',
                messages = { 'ClearNodeSorters', 'ExplorePwdAsync' },
            },
            ['e'] = {
                help = 'by canonical extension',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'ByCanonicalExtension',
                            reverse = false,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            enter = {
                help = 'done',
                messages = { 'PopMode' },
            },
            ['m'] = {
                help = 'by canonical mime essence',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'ByCanonicalMimeEssence',
                            reverse = false,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            ['n'] = {
                help = 'by node type',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'ByCanonicalIsDir',
                            reverse = false,
                        },
                    },
                    {
                        AddNodeSorter = {
                            sorter = 'ByCanonicalIsFile',
                            reverse = false,
                        },
                    },
                    {
                        AddNodeSorter = {
                            sorter = 'ByIsSymlink',
                            reverse = false,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            ['r'] = {
                help = 'by relative path',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'ByIRelativePath',
                            reverse = false,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
            ['s'] = {
                help = 'by size',
                messages = {
                    {
                        AddNodeSorter = {
                            sorter = 'BySize',
                            reverse = false,
                        },
                    },
                    'ExplorePwdAsync',
                },
            },
        },
        on_alphabet = nil,
        on_number = nil,
        on_special_character = nil,
        default = nil,
    },
}

xplr.config.modes.builtin.sort.key_bindings.on_key['esc'] = xplr.config.modes.builtin.sort.key_bindings.on_key.enter
