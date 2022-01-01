xplr.config.modes.builtin.create = {
    name = "create",
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ["ctrl-c"] = {
                help = "terminate",
                messages = {"Terminate"}
            },
            ["d"] = {
                help = "create directory",
                messages = {
                    {
                        SwitchModeBuiltin = "create directory"
                    },
                    {
                        SetInputBuffer = ""
                    }
                }
            },
            esc = {
                help = "cancel",
                messages = {"PopMode"}
            },
            ["f"] = {
                help = "create file",
                messages = {
                    {
                        SwitchModeBuiltin = "create file"
                    },
                    {
                        SetInputBuffer = ""
                    }
                }
            }
        },
        on_alphabet = nil,
        on_number = nil,
        on_special_character = nil,
        default = nil
    }
}
