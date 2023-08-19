return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-refactor',
            'RRethy/nvim-treesitter-endwise',
        },
        event = {
            'VeryLazy',
            'BufReadPre',
            'BufNewFile',
        },
        cmd = {
            'TSBufDisable',
            'TSBufEnable',
            'TSBufToggle',
            'TSCaptureUnderCursor',
            'TSConfigInfo',
            'TSContextDisable',
            'TSContextEnable',
            'TSContextToggle',
            'TSDisable',
            'TSEditQuery',
            'TSEditQueryUserAfter',
            'TSEnable',
            'TSHighlightCapturesUnderCursor',
            'TSInstall',
            'TSInstallFromGrammar',
            'TSInstallInfo',
            'TSInstallSync',
            'TSModuleInfo',
            'TSNodeUnderCursor',
            'TSTextobjectGotoNextEnd',
            'TSTextobjectGotoNextStart',
            'TSTextobjectGotoPreviousEnd',
            'TSTextobjectGotoPreviousStart',
            'TSTextobjectPeekDefinitionCode',
            'TSTextobjectSelect',
            'TSTextobjectSwapNext',
            'TSTextobjectSwapPrevious',
            'TSToggle',
            'TSUninstall',
            'TSUpdate',
            'TSUpdateSync',
        },
        build = ':TSUpdate',
        config = CONF.treesitter,
    },
    {
        'nvim-treesitter/playground',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        cmd = {
            'TSPlaygroundToggle',
        },
    },
    {
        'andymass/vim-matchup',
        keys = { '%' },
        event = { 'BufReadPost', 'BufNewFile' },
        init = function()
            vim.g.loaded_matchit = 1
        end,
        config = function()
            for _, mod in ipairs { 'loader', 'matchparen' } do
                if _G['matchup_' .. mod .. '_enabled'] == 1 then
                    vim.schedule(function()
                        vim.fn['matchup#' .. mod .. '#init_module']()
                    end)
                end
            end
        end,
    },
    { 'ThePrimeagen/jvim.nvim', ft = 'json' },
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPost',
        config = true,
    },
    {
        'Wansmer/treesj',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        keys = {
            { '<leader>M', '<cmd>TSJToggle<cr>' },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
}
