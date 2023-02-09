return {
    -- Plenary
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'nvim-lua/popup.nvim', lazy = true },
    {
        'anuvyklack/hydra.nvim',
        event = 'VeryLazy',
        config = function()
            for _, source in ipairs(vim.api.nvim_get_runtime_file('lua/dtomvan/config/hydra/*.lua', true)) do
                loadfile(source)()
            end
        end,
    },
    {
        'rcarriga/nvim-notify',
        lazy = true,
    },

    {
        'numToStr/Comment.nvim',
        config = true,
        keys = {
            'gcc',
            'gbc',
            { 'gc', mode = { 'n', 'v' } },
            { 'gb', mode = { 'n', 'v' } },
            'gcO',
            'gco',
            'gcA',
        },
    },
    {
        'numToStr/Navigator.nvim',
        config = true,
        keys = {
            { '<A-h>', '<cmd>NavigatorLeft<cr>' },
            { '<A-j>', '<cmd>NavigatorDown<cr>' },
            { '<A-k>', '<cmd>NavigatorUp<cr>' },
            { '<A-l>', '<cmd>NavigatorRight<cr>' },
            { '<A-p>', '<cmd>NavigatorPrevious<cr>' },
        },
    },
    {
        'mg979/vim-visual-multi',
        event = 'BufReadPost',
    },

    -- Prime goodness
    {
        'ThePrimeagen/harpoon',
        lazy = true,
    },
    'ThePrimeagen/refactoring.nvim',
    { 'ThePrimeagen/vim-be-good', cmd = 'VimBeGood' },
    { 'ThePrimeagen/jvim.nvim', ft = 'json' },

    -- Git signs
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPost',
        config = true,
    },

    -- Use Telescope as vim.ui.select
    -- and a fancy prompt for vim.ui.input
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.input(...)
            end
        end,
    },

    -- Rust or Bust
    { 'ron-rs/ron.vim', ft = 'ron' },
    'simrat39/rust-tools.nvim',

    -- Lsp
    {
        'williamboman/mason.nvim',
        lazy = true,
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/lsp_extensions.nvim',
        },
        config = true,
        build = function()
            require('mason.api.command').MasonInstall {
                'black',
                'stylua',
                'shellcheck',
            }
        end,
    },

    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        opts = {
            ensure_installed = {
                'clangd',
                'gopls',
                'kotlin_language_server',
                'pylsp',
                'rust_analyzer',
                'sumneko_lua',
            },
        },
    },

    {
        'jay-babu/mason-null-ls.nvim',
        lazy = true,
        config = function()
            require('mason-null-ls').setup {
                automatic_setup = true,
            }
            require('null-ls').setup {
                on_attach = require('dtomvan.lsp.opts').on_attach,
            }
            require('mason-null-ls').setup_handlers()
            for _, source in ipairs(vim.api.nvim_get_runtime_file('lua/dtomvan/config/null-ls/*.lua', true)) do
                loadfile(source)()
            end
        end,
    },
    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        event = 'BufReadPost',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function()
            require 'dtomvan.config.luasnip'
        end,
    },

    -- Kotlin
    { 'udalov/kotlin-vim', ft = 'kotlin' },

    -- Misc
    'michaeljsmith/vim-indent-object',
    {
        'lukas-reineke/indent-blankline.nvim',
        opts = {
            show_current_context = true,
            show_current_context_start = true,
        },
    },
    {
        'chentoast/marks.nvim',
        event = 'BufReadPost',
        opts = {},
    },
    {
        'junegunn/vim-easy-align',
        keys = {
            { 'ga', '<plug>(EasyAlign)', mode = { 'n', 'x' }, remap = true },
            { 'gA', '<plug>(LiveEasyAlign)', mode = { 'n', 'x' }, remap = true },
        },
    },
    {
        'andymass/vim-matchup',
        event = 'BufReadPost',
    },
    {
        'kevinhwang91/nvim-bqf',
        ft = 'qf',
        config = true,
    },
    {
        'Raimondi/vim-transpose-words',
        cmd = 'TransposeWords',
    },
    {
        'numToStr/FTerm.nvim',
        opts = {
            border = 'rounded',
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
            blend = 20,
        },
        keys = {
            {
                '<A-i>',
                function()
                    require('FTerm').toggle()
                end,
                mode = { 'n', 't' },
                desc = 'Toggle terminal',
            },
        },
    },

    {
        'prichrd/netrw.nvim',
        config = true,
    },

    {
        'j-morano/buffer_manager.nvim',
        config = function()
            vim.g.buffer_manager_log_level = 'fatal'
        end,
        keys = {
            {
                '<c-b>',
                function()
                    require('buffer_manager.ui').toggle_quick_menu()
                end,
                desc = 'Buffer manager',
            },
        },
    },

    {
        'gaoDean/autolist.nvim',
        config = true,
        event = {
            'FileType text',
            'FileType markdown',
            'FileType tex',
            'FileType plaintex',
        },
    },

    -- Only when using on specific machine,
    -- since I don't want to get prompted on others.
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
        cond = function()
            return (not vim.g._no_vimtex) and not vim.g.started_by_firenvim
        end,
        ft = 'tex',
        config = function()
            vim.g.tex_conceal = 'abdmg'
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_view_method = 'zathura'
        end,
    },

    {
        'stevearc/oil.nvim',
        config = true,
        keys = {
            {
                '-',
                function()
                    require('oil').open()
                end,
                { desc = 'Open parent directory' },
            },
        },
    },
    {
        'folke/zen-mode.nvim',
        dependencies = { {
            'folke/twilight.nvim',
            config = true,
        } },
        cmd = 'ZenMode',
        opts = {
            window = {
                options = {
                    concealcursor = 'n',
                    conceallevel = 3,
                    cursorcolumn = false,
                    cursorline = false,
                    foldcolumn = '0',
                    list = false,
                    number = false,
                    relativenumber = false,
                    signcolumn = 'no',
                    statusline = ' ',
                },
            },
            on_open = function()
                _G.rerun_noice = require('noice.config').is_running()
                require('noice').disable()
            end,
            on_close = function()
                if _G.rerun_noice then
                    require('noice').enable()
                end
            end,
        },
    },
    {
        'luukvbaal/statuscol.nvim',
        event = 'UIEnter',
        config = {
            setopt = true,
        },
    },
}
