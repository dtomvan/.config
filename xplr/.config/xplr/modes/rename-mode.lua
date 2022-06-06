xplr.config.modes.builtin.rename = {
    name = 'rename',
    help = nil,
    extra_help = nil,
    key_bindings = {
        on_key = {
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            ['ctrl-u'] = {
                help = 'remove line',
                messages = {
                    {
                        SetInputBuffer = '',
                    },
                },
            },
            ['ctrl-w'] = {
                help = 'remove last word',
                messages = { 'RemoveInputBufferLastWord' },
            },
            enter = {
                help = 'rename',
                messages = {
                    {
                        BashExecSilently = [===[
                        SRC="${XPLR_FOCUS_PATH:?}"
                        TARGET="${XPLR_INPUT_BUFFER:?}"
                        mv -- "${SRC:?}" "${TARGET:?}" \
                        && echo ExplorePwd >> "${XPLR_PIPE_MSG_IN:?}" \
                        && echo FocusByFileName: "'"$TARGET"'" >> "${XPLR_PIPE_MSG_IN:?}" \
                        && echo LogSuccess: $SRC renamed to $TARGET >> "${XPLR_PIPE_MSG_IN:?}"
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
        default = {
            help = nil,
            messages = { 'UpdateInputBufferFromKey' },
        },
    },
}
