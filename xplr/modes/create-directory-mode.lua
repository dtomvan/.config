xplr.config.modes.builtin.create_directory = {
    name = "create directory",
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            backspace = {
                help = "remove last character",
                messages = {"RemoveInputBufferLastCharacter"}
            },
            ["ctrl-c"] = {
                help = "terminate",
                messages = {"Terminate"}
            },
            ["ctrl-u"] = {
                help = "remove line",
                messages = {
                    {
                        SetInputBuffer = ""
                    }
                }
            },
            ["ctrl-w"] = {
                help = "remove last word",
                messages = {"RemoveInputBufferLastWord"}
            },
            enter = {
                help = "create directory",
                messages = {
                    {
                        BashExecSilently = [===[
                        PTH="$XPLR_INPUT_BUFFER"
                        if [ "${PTH}" ]; then
                            mkdir -p -- "${PTH:?}" \
                            && echo "SetInputBuffer: ''" >> "${XPLR_PIPE_MSG_IN:?}" \
                            && echo ExplorePwd >> "${XPLR_PIPE_MSG_IN:?}" \
                            && echo LogSuccess: $PTH created >> "${XPLR_PIPE_MSG_IN:?}" \
                            && echo FocusByFileName: "'"$PTH"'" >> "${XPLR_PIPE_MSG_IN:?}"
                        else
                            echo PopMode >> "${XPLR_PIPE_MSG_IN:?}"
                            fi
                            ]===]
                        }
                    }
                },
                esc = {
                    help = "cancel",
                    messages = {
                        "PopMode",
                        {
                            SwitchModeBuiltin = "create"
                        }
                    }
                }
            },
            on_alphabet = nil,
            on_number = nil,
            on_special_character = nil,
            default = {
                help = nil,
                messages = {"BufferInputFromKey"}
            }
        }
    }
