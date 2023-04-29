local hydra = require 'dtomvan.config.hydra'
local o = hydra.o

local hint = [[
_<space>_: Open
^
^ ^ Modes:
^ ^ _s_: Status
^ ^ _b_: Branch
^ ^ _l_: Log
^ ^ _S_: Stash
]]

return {
    name = 'LazyGit',
    hint = hint,
    config = {
        hint = {
            border = 'rounded',
            position = 'middle',
        },
        invoke_on_body = true,
    },
    mode = { 'n' },
    body = '<leader>gg',
    heads = {
        o('<space>', 'Lazygit'),
        o('s', 'Lazygit status'),
        o('b', 'Lazygit branch'),
        o('l', 'Lazygit log'),
        o('S', 'Lazygit stash'),
        { '<esc>', nil, { exit = true, nowait = true, desc = 'exit' } },
        { 'q',     nil, { exit = true, nowait = true, desc = 'exit' } },
    },
}
