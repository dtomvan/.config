require('packer').startup(function()
    -- Packer
    -- Unused, as managed by home-manager
    -- use 'wbthomason/packer.nvim'

    -- Startup time improvements
    use {
        'lewis6991/impatient.nvim',
        config = function()
            require 'impatient'
        end,
    }
    use 'nathom/filetype.nvim'

    -- Plenary
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    -- Color scheme
    use {
        'rebelot/kanagawa.nvim',
        config = function()
            local hl = vim.api.nvim_set_hl
            vim.o.background = 'dark'
            EX.colorscheme 'kanagawa'
            if vim.g.neovide == nil then
                vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
            end
            -- Neovim 0.7 'laststatus' specific
            if vim.fn.has 'nvim-0.7' then
                hl(0, 'WinSeparator', { bg = 'NONE', ctermbg = 'NONE' })
            end
        end,
    }

    -- After opening a file, return to the last position
    use {
        'ethanholz/nvim-lastplace',
        config = function()
            require('nvim-lastplace').setup()
        end,
    }

    -- Status line
    use {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup {}
        end,
        requires = 'nvim-lua/lsp-status.nvim',
    }
    use {
        'tjdevries/express_line.nvim',
        config = function()
            R 'dtomvan.plugins.express_line'
        end,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    -- Prime goodness
    use 'ThePrimeagen/harpoon'
    use 'ThePrimeagen/refactoring.nvim'
    use { 'ThePrimeagen/vim-be-good', cmd = 'VimBeGood' }
    use 'theprimeagen/jvim.nvim'

    -- Git signs
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {}
        end,
    }

    -- TJ telescope Johnson
    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            R 'dtomvan.plugins.telescope'
        end,
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- Use Telescope as vim.ui.select
    -- and a fancy prompt for vim.ui.input
    use {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup {}
        end,
    }

    -- Rust or Bust
    use { 'ron-rs/ron.vim', ft = 'ron' }
    use { 'rust-lang/rust.vim', ft = 'rust' }
    use { 'cespare/vim-toml', ft = 'toml' }
    use 'simrat39/rust-tools.nvim'

    -- Lsp
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            EX.TSUpdate()
        end,
        config = function()
            R 'dtomvan.plugins.treesitter'
        end,
    }

    use 'tjdevries/nlua.nvim'
    use {
        'williamboman/nvim-lsp-installer',
        run = function()
            local servers = {
                'rust_analyzer',
                -- 'taplo',
                'pylsp',
                'kotlin_language_server',
            }
            EX.LspInstall(servers)
        end,
    }
    use 'ray-x/lsp_signature.nvim'

    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('null-ls').setup {
                sources = {
                    require('null-ls').builtins.formatting.stylua,
                    require('null-ls').builtins.formatting.taplo,
                    require('null-ls').builtins.formatting.black,
                },
            }
        end,
        requires = { 'nvim-lua/plenary.nvim' },
    }

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
            'onsails/lspkind-nvim',
            'saadparwaiz1/cmp_luasnip',
            { 'rafamadriz/friendly-snippets', opt = true },
        },
        config = function()
            R 'dtomvan.plugins.luasnip'
            R 'dtomvan.plugins.cmp'
        end,
    }

    -- Auto pairs
    use 'rstacruz/vim-closer'
    use 'Krasjet/auto.pairs'

    -- Kotlin
    use 'udalov/kotlin-vim'

    -- xplr
    use {
        'fhill2/xplr.nvim',
        run = function()
            require('xplr').install { hide = true }
            R 'dtomvan.plugins.xplr'
        end,
        requires = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
    }

    -- Misc
    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                stages = 'fade_in_slide_out',
                on_open = nil,
                on_close = nil,
                render = 'default',
                timeout = 5000,
                background_colour = '#000000',
                max_width = function()
                    return math.floor(vim.opt.columns:get() / 4)
                end,
            }

            -- Default vim notify + the plugin
            vim.notify = function(msg, level)
                require 'notify'(msg, level)
                if level == vim.log.levels.ERROR then
                    vim.api.nvim_err_writeln(msg)
                elseif level == vim.log.levels.WARN then
                    vim.api.nvim_echo({ { msg, 'WarningMsg' } }, true, {})
                else
                    vim.api.nvim_echo({ { msg } }, true, {})
                end
            end
        end,
    }

    -- Misc
    use 'tversteeg/registers.nvim'
    use 'junegunn/vim-easy-align'
    use 'andymass/vim-matchup'
    use 'stefandtw/quickfix-reflector.vim'
    use 'ggandor/lightspeed.nvim'
    use 'Raimondi/vim-transpose-words'
    use {
        'numToStr/FTerm.nvim',
        config = function()
            require('FTerm').setup {
                border = 'rounded',
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
                blend = 20,
            }

            vim.keymap.set({ 'n', 't' }, '<A-i>', require('FTerm').toggle)
        end,
    }

    -- Neorg
    use {
        'nvim-neorg/neorg',
        config = function()
            R 'dtomvan.plugins.norg'
        end,
        run = ':TSInstall norg norg_meta norg_table',
        requires = 'nvim-lua/plenary.nvim',
    }

    -- Profiler
    use 'dstein64/vim-startuptime'
    -- Only when using on specific machine,
    -- since I don't want to get prompted on others.
    if vim.fn.hostname() == 'tom-pc' then
        -- Developer profiler
        use 'wakatime/vim-wakatime'
    end
end)
