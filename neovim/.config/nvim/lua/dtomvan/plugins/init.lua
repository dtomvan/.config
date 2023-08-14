-- This file is meant as a very general listing of common "dependency" plugins.
-- Plugins with actual features will be included in separate files.
return {
    { 'nvim-lua/plenary.nvim', lazy = true },

    { 'nvim-lua/popup.nvim',   lazy = true },

    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            local wk = require 'which-key'

            wk.setup {}
            wk.register({
                c = { name = 'Terminal' },
                d = { name = 'Dot' },
                f = { name = 'Find' },
                g = { name = 'Goto', f = 'File' },
                r = { name = 'Re...' },
                t = { name = 'Transpose/Term' },
                w = { name = 'LSP Workspace' },
            }, { prefix = '<leader>' })
            wk.register({}, { prefix = '\\' })
        end,
    },

    {
        'anuvyklack/hydra.nvim',
        lazy = true,
        init = function()
            local hydra = require 'dtomvan.config.hydra'
            for _, source in
            ipairs(
                vim.api.nvim_get_runtime_file(
                    'lua/dtomvan/config/hydra/*.lua',
                    true
                )
            )
            do
                local ok, err = pcall(hydra.setup, loadfile(source)())
                if not ok then
                    vim.notify(
                        ('Invalid hydra in file `%s`: %s'):format(
                            vim.fn.fnamemodify(source, ':~:.'),
                            err
                        )
                    )
                end
            end
        end,
    },

    {
        'rcarriga/nvim-notify',
        lazy = true,
        opts = {
            background_colour = '#00000000',
            fps = 40,
            render = 'simple',
            stages = 'slide',
        },
    },

    {
        'lambdalisue/suda.vim',
        cmd = {
            'SudaRead',
            'SudaWrite',
        },
    },

    {
        'wakatime/vim-wakatime',
        event = 'VeryLazy',
        enabled = function()
            return vim.fn.hostname() == 'tom-pc'
        end,
    },

    -- LaTeX
    {
        'lervag/vimtex',
        cond = not vim.g._no_vimtex and not vim.g.started_by_firenvim,
        ft = 'tex',
        config = function()
            vim.g.tex_conceal = 'abdmg'
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_view_method = 'zathura'
        end,
    },

    {
        'luukvbaal/statuscol.nvim',
        event = 'UIEnter',
        config = {
            setopt = true,
        },
    },

    {
        'sQVe/bufignore.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
    },
}
