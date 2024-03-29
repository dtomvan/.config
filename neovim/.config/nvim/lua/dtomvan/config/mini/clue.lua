local clue = require('mini.clue')
clue.setup {
    window = {
        config = {
            anchor = 'SW',
            row = 'auto',
            col = 'auto',
            width = 'auto',
        },
    },
    triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        { mode = 'i', keys = '<C-x>' },
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },

    clues = {
        { mode = 'n', keys = '<Leader>c',  desc = '+Terminal' },
        { mode = 'n', keys = '<Leader>d',  desc = '+Dot' },
        { mode = 'n', keys = '<Leader>f',  desc = '+Find' },
        { mode = 'n', keys = '<Leader>g',  desc = '+Goto' },
        { mode = 'n', keys = '<Leader>gf', desc = '+file' },
        { mode = 'n', keys = '<Leader>r',  desc = '+Re...' },
        { mode = 'n', keys = '<Leader>t',  desc = '+Transpose/Term' },
        { mode = 'n', keys = '<Leader>w',  desc = '+LSP Workspace' },
        clue.gen_clues.builtin_completion(),
        clue.gen_clues.g(),
        clue.gen_clues.marks(),
        clue.gen_clues.registers(),
        clue.gen_clues.windows(),
        clue.gen_clues.z(),
    },
}
