local sessions = require 'mini.sessions'
sessions.setup {}

local starter = require 'mini.starter'
starter.setup {
    items = {
        starter.sections.telescope(),
        starter.sections.sessions(),
        starter.sections.recent_files(),
        starter.sections.builtin_actions(),
    },
    content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning('center', 'center'),
    },
}
