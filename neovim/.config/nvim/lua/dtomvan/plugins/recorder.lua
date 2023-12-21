return {
    'chrisgrieser/nvim-recorder',
    enabled = false,
    opts = {
        slots = { 'a', 'b', 'c', 'd' },
        mapping = {
            startStopRecording = 'Q',
            playMacro = 'dq',
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
