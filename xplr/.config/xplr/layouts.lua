---- Builtin
------ Default
xplr.config.layouts.builtin.default = {
    Horizontal = {
        config = {
            margin = 0,
            horizontal_margin = 0,
            vertical_margin = 0,
            constraints = {
                {
                    Percentage = 70,
                },
                {
                    Percentage = 30,
                },
            },
        },
        splits = {
            {
                Vertical = {
                    config = {
                        margin = 0,
                        horizontal_margin = nil,
                        vertical_margin = nil,
                        constraints = {
                            {
                                Length = 3,
                            },
                            {
                                Min = 1,
                            },
                            {
                                Length = 3,
                            },
                        },
                    },
                    splits = {
                        'SortAndFilter',
                        'Table',
                        'InputAndLogs',
                    },
                },
            },
            {
                Vertical = {
                    config = {
                        margin = 0,
                        horizontal_margin = nil,
                        vertical_margin = nil,
                        constraints = {
                            {
                                Percentage = 50,
                            },
                            {
                                Percentage = 50,
                            },
                        },
                    },
                    splits = {
                        'Selection',
                        'HelpMenu',
                    },
                },
            },
        },
    },
}

------ No help
xplr.config.layouts.builtin.no_help = {
    Horizontal = {
        config = {
            margin = nil,
            horizontal_margin = nil,
            vertical_margin = nil,
            constraints = {
                {
                    Percentage = 70,
                },
                {
                    Percentage = 30,
                },
            },
        },
        splits = {
            {
                Vertical = {
                    config = {
                        margin = nil,
                        horizontal_margin = nil,
                        vertical_margin = nil,
                        constraints = {
                            {
                                Length = 3,
                            },
                            {
                                Min = 1,
                            },
                            {
                                Length = 3,
                            },
                        },
                    },
                    splits = {
                        'SortAndFilter',
                        'Table',
                        'InputAndLogs',
                    },
                },
            },
            'Selection',
        },
    },
}

------ No selection
xplr.config.layouts.builtin.no_selection = {
    Horizontal = {
        config = {
            margin = nil,
            horizontal_margin = nil,
            vertical_margin = nil,
            constraints = {
                {
                    Percentage = 70,
                },
                {
                    Percentage = 30,
                },
            },
        },
        splits = {
            {
                Vertical = {
                    config = {
                        margin = nil,
                        horizontal_margin = nil,
                        vertical_margin = nil,
                        constraints = {
                            {
                                Length = 3,
                            },
                            {
                                Min = 1,
                            },
                            {
                                Length = 3,
                            },
                        },
                    },
                    splits = {
                        'SortAndFilter',
                        'Table',
                        'InputAndLogs',
                    },
                },
            },
            'HelpMenu',
        },
    },
}

------ No help, no selection
xplr.config.layouts.builtin.no_help_no_selection = {
    Vertical = {
        config = {
            margin = nil,
            horizontal_margin = nil,
            vertical_margin = nil,
            constraints = {
                {
                    Length = 3,
                },
                {
                    Min = 1,
                },
                {
                    Length = 3,
                },
            },
        },
        splits = {
            'SortAndFilter',
            'Table',
            'InputAndLogs',
        },
    },
}

---- Custom
xplr.config.layouts.custom = {}

xplr.config.layouts.custom.logs_only = 'InputAndLogs'
