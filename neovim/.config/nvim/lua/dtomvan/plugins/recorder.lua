return {
    'chrisgrieser/nvim-recorder',
    opts = {
        slots = { 'a', 'b', 'c', 'd' },
        mapping = {
            startStopRecording = 'Q',
            playMacro = 'qq',
            switchSlot = 'QQ',
            editMacro = 'cq',
            yankMacro = 'yq',
            addBreakPoint = '[;',
        },
        clear = false,
        logLevel = vim.log.levels.INFO,
        dapSharedKeymaps = false,
    },
}
