xplr.config.modes.builtin.go_to = {
  name = "go to",
  help = nil,
  extra_help = nil,
  key_bindings = {
    on_key = {
      ["ctrl-c"] = {
        help = "terminate",
        messages = {"Terminate"}
      },
      esc = {
        help = "cancel",
        messages = {"PopMode"}
      },
      ["f"] = {
        help = "follow symlink",
        messages = {"FollowSymlink", "PopMode"}
      },
      ["g"] = {
        help = "top",
        messages = {"FocusFirst", "PopMode"}
      },
      ["x"] = {
        help = "open in gui",
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
            $OPENER "${XPLR_FOCUS_PATH:?}" > /dev/null 2>&1
            ]===]
          },
          "ClearScreen",
          "PopMode",
        }
      }
    },
    on_alphabet = nil,
    on_number = nil,
    on_special_character = nil,
    default = nil
  }
}
