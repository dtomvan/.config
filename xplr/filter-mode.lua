xplr.config.modes.builtin.filter = {
  name = "filter",
  help = nil,
  extra_help = nil,
  key_bindings = {
    on_key = {
      ["R"] = {
        help = "relative does not contain",
        messages = {
          {
            SwitchModeBuiltin = "relative_path_does_not_contain"
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
      backspace = {
        help = "remove last filter",
        messages = {"RemoveLastNodeFilter", "ExplorePwdAsync"}
      },
      ["ctrl-c"] = {
        help = "terminate",
        messages = {"Terminate"}
      },
      ["ctrl-r"] = {
        help = "reset filters",
        messages = {"ResetNodeFilters", "ExplorePwdAsync"}
      },
      ["ctrl-u"] = {
        help = "clear filters",
        messages = {"ClearNodeFilters", "ExplorePwdAsync"}
      },
      enter = {
        help = "done",
        messages = {"PopMode"}
      },
      ["r"] = {
        help = "relative does contain",
        messages = {
          {
            SwitchModeBuiltin = "relative_path_does_contain"
          },
          {
            SetInputBuffer = ""
          },
          {
            AddNodeFilterFromInput = "IRelativePathDoesContain"
          },
          "ExplorePwdAsync"
        }
      }
    },
    on_alphabet = nil,
    on_number = nil,
    on_special_character = nil,
    default = nil
  }
}

xplr.config.modes.builtin.filter.key_bindings.on_key["esc"] = xplr.config.modes.builtin.filter.key_bindings.on_key.enter
