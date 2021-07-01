xplr.config.modes.builtin.relative_path_does_contain = {
  name = "relative path does contain",
  help = nil,
  extra_help = nil,
  key_bindings = {
    on_key = {
      backspace = {
        help = "remove last character",
        messages = {
          {
            RemoveNodeFilterFromInput = "IRelativePathDoesContain"
          },
          "RemoveInputBufferLastCharacter",
          {
            AddNodeFilterFromInput = "IRelativePathDoesContain"
          },
          "ExplorePwdAsync"
        }
      },
      ["ctrl-c"] = {
        help = "terminate",
        messages = {"Terminate"}
      },
      ["ctrl-u"] = {
        help = "remove line",
        messages = {
          {
            RemoveNodeFilterFromInput = "IRelativePathDoesContain"
          },
          {
            SetInputBuffer = ""
          },
          {
            AddNodeFilterFromInput = "IRelativePathDoesContain"
          },
          "ExplorePwdAsync"
        }
      },
      ["ctrl-w"] = {
        help = "remove last word",
        messages = {
          {
            RemoveNodeFilterFromInput = "IRelativePathDoesContain"
          },
          "RemoveInputBufferLastWord",
          {
            AddNodeFilterFromInput = "IRelativePathDoesContain"
          },
          "ExplorePwdAsync"
        }
      },
      enter = {
        help = "apply filter",
        messages = {"PopMode"}
      },
      esc = {
        help = "cancel",
        messages = {
          {
            RemoveNodeFilterFromInput = "IRelativePathDoesContain"
          },
          "PopMode",
          "ExplorePwdAsync",
        }
      }
    },
    on_alphabet = nil,
    on_number = nil,
    on_special_character = nil,
    default = {
      help = nil,
      messages = {
        {
          RemoveNodeFilterFromInput = "IRelativePathDoesContain"
        },
        "BufferInputFromKey",
        {
          AddNodeFilterFromInput = "IRelativePathDoesContain"
        },
        "ExplorePwdAsync"
      }
    }
  }
}
