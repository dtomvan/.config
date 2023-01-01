return {
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    event = "BufReadPre",
    cmd = { "TSBufDisable", "TSBufEnable", "TSBufToggle", "TSCaptureUnderCursor", "TSConfigInfo", "TSContextDisable",
        "TSContextEnable", "TSContextToggle", "TSDisable", "TSEditQuery", "TSEditQueryUserAfter", "TSEnable",
        "TSHighlightCapturesUnderCursor", "TSInstall", "TSInstallFromGrammar", "TSInstallInfo", "TSInstallSync",
        "TSModuleInfo", "TSNodeUnderCursor", "TSPlaygroundToggle", "TSTextobjectGotoNextEnd", "TSTextobjectGotoNextStart",
        "TSTextobjectGotoPreviousEnd", "TSTextobjectGotoPreviousStart", "TSTextobjectPeekDefinitionCode",
        "TSTextobjectSelect", "TSTextobjectSwapNext", "TSTextobjectSwapPrevious", "TSToggle", "TSUninstall", "TSUpdate",
        "TSUpdateSync" },
    build = ':TSUpdate',
    config = function()
        require 'dtomvan.config.treesitter'
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-refactor',
    },
}
