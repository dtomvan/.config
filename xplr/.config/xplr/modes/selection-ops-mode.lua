xplr.config.modes.builtin.selection_ops = {
    name = 'selection ops',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ['c'] = {
                help = 'copy here',
                messages = {
                    {
                        BashExec = [===[
                        (while IFS= read -r line; do
                        if cp -vr -- "${line:?}" ./; then
                            echo LogSuccess: $line copied to $PWD >> "${XPLR_PIPE_MSG_IN:?}"
                        else
                            echo LogError: Failed to copy $line to $PWD >> "${XPLR_PIPE_MSG_IN:?}"
                            fi
                            done < "${XPLR_PIPE_SELECTION_OUT:?}")
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
            esc = {
                help = 'cancel',
                messages = { 'PopMode' },
            },
            ['m'] = {
                help = 'move here',
                messages = {
                    {
                        BashExec = [===[
                            (while IFS= read -r line; do
                            result=$(mv -v -- "${line:?}" ./)
                            if [[ -n $result ]]; then
                                echo $result
                                filename=$(echo $result | awk -F" -> " '{ print $2 }' | sed "s/'//g")
                                toselect="$PWD/$filename"
                                echo LogSuccess: $line moved to $PWD >> "${XPLR_PIPE_MSG_IN:?}"
                                echo SelectPath: $toselect >> "${XPLR_PIPE_MSG_IN:?}"
                            else
                                echo LogError: Failed to move $line to $PWD >> "${XPLR_PIPE_MSG_IN:?}"
                                fi
                                done < "${XPLR_PIPE_SELECTION_OUT:?}")
                                echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
                                read -p "[enter to continue]"
                                ]===],
                    },
                    'PopMode',
                },
            },
            ['x'] = {
                help = 'open in gui',
                messages = {
                    {
                        BashExecSilently = [===[
                                if [ -z "$OPENER" ]; then
                                    if command -v xdg-open; then
                                        OPENER=xdg-open
                                        elif command -v open; then
                                        OPENER=open
                                    else
                                        echo 'LogError: $OPENER not found' >> "${XPLR_PIPE_MSG_IN:?}"
                                        exit 1
                                        fi
                                        fi
                                        (while IFS= read -r line; do
                                        $OPENER "${line:?}" > /dev/null 2>&1
                                        done < "${XPLR_PIPE_RESULT_OUT:?}")
                                        ]===],
                    },
                    'ClearScreen',
                    'PopMode',
                },
            },
        },
        on_alphabet = nil,
        on_number = nil,
        on_special_character = nil,
        default = nil,
    },
}
