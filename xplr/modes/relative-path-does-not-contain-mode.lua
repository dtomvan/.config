xplr.config.modes.builtin.relative_path_does_not_contain = {
    name = "relative path does not contain",
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            backspace = {
                help = "remove last character",
                messages = {
                    {
                        RemoveNodeFilterFromInput = "IRelativePathDoesNotContain"
                    },
                    "RemoveInputBufferLastCharacter",
                    {
                        AddNodeFilterFromInput = "IRelativePathDoesNotContain"
                    },
                    "ExplorePwdAsync"
                }
            },
            ["ctrl-c"] = {
                help = "terminate",
                messages = {"Terminate"}
            },
            ["ctrl-u"] = {
                help = "remove line",
                messages = {
                    {
                        RemoveNodeFilterFromInput = "IRelativePathDoesNotContain"
                    },
                    {
                        SetInputBuffer = ""
                    },
                    {
                        AddNodeFilterFromInput = "IRelativePathDoesNotContain"
                    },
                    "ExplorePwdAsync"
                }
            },
            ["ctrl-w"] = {
                help = "remove last word",
                messages = {
                    {
                        RemoveNodeFilterFromInput = "IRelativePathDoesNotContain"
                    },
                    "RemoveInputBufferLastWord",
                    {
                        AddNodeFilterFromInput = "IRelativePathDoesNotContain"
                    },
                    "ExplorePwdAsync"
                }
            },
            enter = {
                help = "apply filter",
                messages = {"PopMode"}
            },
            esc = {
                help = "cancel",
                messages = {
                    {
                        RemoveNodeFilterFromInput = "IRelativePathDoesNotContain"
                    },
                    "PopMode",
                    "ExplorePwdAsync"
                }
            }
        },
        on_alphabet = nil,
        on_number = nil,
        on_special_character = nil,
        default = {
            help = nil,
            messages = {
                {
                    RemoveNodeFilterFromInput = "IRelativePathDoesNotContain"
                },
                "BufferInputFromKey",
                {
                    AddNodeFilterFromInput = "IRelativePathDoesNotContain"
                },
                "ExplorePwdAsync"
            }
        }
    }
}
