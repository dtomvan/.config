require('leap').leap {
    target_windows = { vim.fn.win_getid() },
    action = require('leap-spooky').spooky_action(
        function() return "viw" end,
        { keeppos = true, on_return = (vim.v.operator == 'y') and 'p', }
    ),
}
