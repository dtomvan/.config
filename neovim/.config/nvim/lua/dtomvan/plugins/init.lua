local utils = require 'dtomvan.utils'

-- This file is meant as a very general listing of common "dependency" plugins.
-- Plugins with actual features will be included in separate files.
return {
    { 'nvim-lua/plenary.nvim', lazy = true },

    { 'nvim-lua/popup.nvim',   lazy = true },

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
            -- background_colour = '#00000000',
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
        enabled = utils.is_personal,
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
        config = function()
            local builtin = require 'statuscol.builtin'
            return {
                setopt = true,
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                    {
                        sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
                        click = "v:lua.ScSa"
                    },
                    { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                    {
                        sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                        click = "v:lua.ScSa"
                    },
                }
            }
        end
    },

    {
        'sQVe/bufignore.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
    },
    { 'catppuccin/nvim', name = 'catppuccin' },
}
