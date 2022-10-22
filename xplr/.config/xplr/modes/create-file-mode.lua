xplr.config.modes.builtin.create_file = {
    name = 'create file',
    prompt = (xplr.config.node_types.directory.meta.icon or 'D') .. ' ❯ ',
    key_bindings = {
        on_key = {
            ['tab'] = {
                help = 'try complete',
                messages = {
                    { CallLuaSilently = 'builtin.try_complete_path' },
                },
            },
            ['enter'] = {
                help = 'submit',
                messages = {
                    {
                        BashExecSilently = [===[
              PTH="$XPLR_INPUT_BUFFER"
              if [ "$PTH" ]; then
                mkdir -p -- "$(dirname $PTH)" \
                && touch -- "$PTH" \
                && echo "SetInputBuffer: ''" >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo LogSuccess: $PTH created >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo ExplorePwd >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo FocusPath: "'"$PTH"'" >> "${XPLR_PIPE_MSG_IN:?}"
              else
                echo PopMode >> "${XPLR_PIPE_MSG_IN:?}"
              fi
            ]===],
                    },
                },
            },
        },
        default = {
            messages = {
                'UpdateInputBufferFromKey',
            },
        },
    },
}
