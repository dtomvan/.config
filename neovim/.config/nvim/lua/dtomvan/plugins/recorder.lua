return {
    'chrisgrieser/nvim-recorder',
    opts = {
        slots = { 'a', 'b', 'c', 'd' },
        mapping = {
            startStopRecording = 'q',
            playMacro = 'Q',
            switchSlot = '<C-q>',
            editMacro = 'cq',
            yankMacro = 'yq',
            addBreakPoint = '[;',
        },
        clear = false,
        logLevel = vim.log.levels.INFO,
        dapSharedKeymaps = false,
    },
}
