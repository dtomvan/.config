local toplevel_mode = {
    name = 'git',
    key_bindings = {
        on_key = {
            ['a'] = {
                help = 'git add',
                messages = {
                    'PopMode',
                    {
                        SwitchModeCustom = 'git add',
                    },
                    {
                        SetInputBuffer = '',
                    },
                },
            },
            ['s'] = {
                help = 'git add selected',
                messages = {
                    {
                        BashExec = [===[
                        PTH="$XPLR_PIPE_SELECTION_OUT"
                        if [ "${PTH}" ]; then
                            cat $PTH | xargs git add
                            read -p "[press enter to continue]"
                        fi
                        ]===],
                    },
                },
            },
            ['c'] = {
                help = 'git commit',
                messages = {
                    {
                        BashExec = [===[
                        git commit -v
                        read -p "[press enter to continue]"
                        ]===],
                    },
                    'PopMode',
                    {
                        SwitchModeCustom = 'git',
                    },
                },
            },
            ['b'] = {
                help = 'git branch',
                messages = {
                    {
                        BashExec = [===[
                        git branch | fzf | xargs git checkout
                        echo ExplorePwd >> "${XPLR_PIPE_MSG_IN:?}"
                        ]===],
                    },
                },
            },
            ['p'] = {
                help = 'git push',
                messages = {
                    {
                        BashExec = [===[
                        git push
                        read -p "[press enter to continue]"
                        ]===],
                    },
                },
            },
            ['r'] = {
                help = 'git reset',
                messages = {
                    {
                        BashExec = [===[
                        echo "Are you sure that you wanna reset the tree? (y/N)"
                        read sure
                        if [ "$sure" = "y" ]; then
                            git reset
                        fi
                        read -p "[press enter to continue]"
                        ]===],
                    },
                },
            },
            ['f'] = {
                help = 'git pull',
                messages = {
                    {
                        BashExec = [===[
                        git pull
                        read -p "[press enter to continue]"
                        ]===],
                    },
                },
            },
            ['l'] = {
                help = 'git log',
                messages = {
                    {
                        -- Shamelessly stolen from lf's tips page
                        BashExec = [===[
                        git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
                        read -p "[press enter to continue]"
                        ]===],
                    },
                },
            },
            ['S'] = {
                help = 'git status',
                messages = {
                    {
                        -- Shamelessly stolen from lf's tips page
                        BashExec = [===[
                        git status
                        read -p "[press enter to continue]"
                        ]===],
                    },
                },
            },
            esc = {
                help = 'cancel',
                messages = { 'PopMode' },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
        },
    },
}

local add_mode = {
    name = 'git add',
    key_bindings = {
        on_key = {
            enter = {
                help = 'stage file',
                messages = {
                    {
                        BashExecSilently = [===[
                        PTH="$XPLR_INPUT_BUFFER"
                        if [ "${PTH}" ]; then
                            git add "${PTH:?}" \
                            && echo "SetInputBuffer: ''" >> "${XPLR_PIPE_MSG_IN:?}" \
                            && echo LogSuccess: $PTH staged >> "${XPLR_PIPE_MSG_IN:?}"
                        else
                            echo PopMode >> "${XPLR_PIPE_MSG_IN:?}"
                            echo SwitchModeCustom: git >> "${XPLR_PIPE_MSG_IN:?}"
                        fi
                        ]===],
                    },
                },
            },
            esc = {
                help = 'cancel',
                messages = { 'PopMode' },
            },
            ['ctrl-c'] = {
                help = 'terminate',
                messages = { 'Terminate' },
            },
            backspace = {
                help = 'delete character',
                messages = { 'RemoveInputBufferLastCharacter' },
            },
        },
        default = {
            help = 'enter character',
            messages = { 'UpdateInputBufferFromKey' },
        },
    },
}

return { toplevel_mode = toplevel_mode, add_mode = add_mode }
