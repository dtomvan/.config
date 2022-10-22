xplr.config.modes.builtin.create_directory = {
    name = 'create directory',
    prompt = (xplr.config.node_types.directory.meta.icon or 'F') .. ' ❯ ',
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
              if [ "${PTH}" ]; then
                mkdir -p -- "${PTH:?}" \
                && echo "SetInputBuffer: ''" >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo ExplorePwd >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo LogSuccess: $PTH created >> "${XPLR_PIPE_MSG_IN:?}" \
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
