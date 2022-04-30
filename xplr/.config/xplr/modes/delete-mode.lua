xplr.config.modes.builtin.delete = {
    name = 'delete',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ['D'] = {
                help = 'force delete',
                messages = {
                    {
                        BashExec = [===[
                        (while IFS= read -r line; do
                        if rm -rfv -- "${line:?}"; then
                            echo LogSuccess: $line deleted >> "${XPLR_PIPE_MSG_IN:?}"
                        else
                            echo LogError: Failed to delete $line >> "${XPLR_PIPE_MSG_IN:?}"
                            fi
                            done < "${XPLR_PIPE_RESULT_OUT:?}")
                            echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
                            read -p "[enter to continue]"
                            ]===],
                    },
                    'PopMode',
                },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            ['d'] = {
                help = 'delete',
                messages = {
                    {
                        BashExecSilently = [===[
                            (while IFS= read -r line; do
                            if [ -d "$line" ] && [ ! -L "$line" ]; then
                                if rmdir -v -- "${line:?}"; then
                                    echo LogSuccess: $line deleted >> "${XPLR_PIPE_MSG_IN:?}"
                                else
                                    echo LogError: Failed to delete $line >> "${XPLR_PIPE_MSG_IN:?}"
                                    fi
                                else
                                    if rm -v -- "${line:?}"; then
                                        echo LogSuccess: $line deleted >> "${XPLR_PIPE_MSG_IN:?}"
                                    else
                                        echo LogError: Failed to delete $line >> "${XPLR_PIPE_MSG_IN:?}"
                                        fi
                                        fi
                                        done < "${XPLR_PIPE_RESULT_OUT:?}")
                                        echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
                                        # read -p "[enter to continue]"
                                        ]===],
                    },
                    'PopMode',
                },
            },
            esc = {
                help = 'cancel',
                messages = { 'PopMode' },
            },
        },
        on_alphabet = nil,
        on_number = nil,
        on_special_character = nil,
        default = nil,
    },
}
