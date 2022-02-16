require('packer').startup(function()
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Plenary
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    -- Maps
    use 'b0o/mapx.nvim'

    -- Tpope goodness
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-git'
    use 'tpope/vim-fugitive'

    -- Discord presence
    use 'andweeb/presence.nvim'

    -- Gruvbox (https://www.youtube.com/watch?v=DsyptvUvu3A)
    -- use 'morhetz/gruvbox'
    use 'rebelot/kanagawa.nvim'
    -- Status line
    use 'nvim-lua/lsp-status.nvim'
    use {
        'feline-nvim/feline.nvim',
        config = function()
            vim.o.background = 'dark'
            vim.cmd 'colorscheme kanagawa'
            vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
            if vim.g.feline_has_init ~= 1 then
                local components = require('feline.presets')['noicon']

                table.insert(components.active[2], {
                    provider = 'lsp_current_status',
                    enabled = function()
                        return #vim.lsp.buf_get_clients() > 0
                    end,
                })

                require('feline').setup {
                    components = components,
                    custom_providers = {
                        lsp_current_status = function()
                            local status = require('lsp-status').status()
                            if type(status) == 'string' then
                                -- Hacky way to get rid of extra characters from
                                -- rust_analyzer
                                local result, _ = string.gsub(status, '\240\159\135\187', '')
                                return result
                            else
                                return ' '
                            end
                        end,
                    },
                }
            end
            vim.g.feline_has_init = 1
        end,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    -- Prime goodness
    use 'ThePrimeagen/harpoon'
    use 'ThePrimeagen/refactoring.nvim'
    use 'ThePrimeagen/vim-be-good'
    use {
        'samodostal/is-prime-online.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('is-prime-online').setup {
                source = 'twitch',
                streamer_name = 'ThePrimeagen',
                refresh_interval_in_seconds = 60,
            }

            local timer = vim.loop.new_timer()
            timer:start(
                1000,
                20000,
                vim.schedule_wrap(function()
                    local status = require('is-prime-online').status()
                    if status == true and vim.g.PRIME_STATUS ~= 1 then
                        vim.notify '🟢 Prime is online!'
                        vim.g.PRIME_STATUS = 1
                    elseif status == false and vim.g.PRIME_STATUS == 1 then
                        vim.notify '🔴 Prime is offline.'
                        vim.g.PRIME_STATUS = 0
                    end
                end)
            )
        end,
    }

    -- Git signs
    use 'lewis6991/gitsigns.nvim'

    -- TJ telescope Johnson
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- Rust or Bust
    use 'rust-lang/rust.vim'
    use 'cespare/vim-toml'
    use 'simrat39/rust-tools.nvim'

    -- Lsp
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            vim.cmd [[ TSUpdate ]]
        end,
    }
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'glepnir/lspsaga.nvim'
    use 'tjdevries/nlua.nvim'
    use {
        'williamboman/nvim-lsp-installer',
        run = function()
            vim.cmd [[LspInstall rust_analyzer taplo pylsp kotlin_language_server]]
        end,
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('null-ls').setup {
                sources = {
                    require('null-ls').builtins.formatting.stylua,
                    require('null-ls').builtins.formatting.taplo,
                },
            }
        end,
        requires = { 'nvim-lua/plenary.nvim' },
    }

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    -- Auto pairs
    use 'rstacruz/vim-closer'
    use 'Krasjet/auto.pairs'

    -- Diagnotic plugins by folke
    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup {}
        end,
    }
    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {}
        end,
    }

    -- Kotlin
    use 'udalov/kotlin-vim'

    -- xplr
    use {
        'fhill2/xplr.nvim',
        run = function()
            require('xplr').install { hide = true }
        end,
        requires = { { 'nvim-lua/plenary.nvim' }, { 'MunifTanjim/nui.nvim' } },
    }

    -- Misc
    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                stages = 'fade_in_slide_out',
                on_open = nil,
                on_close = nil,

                -- Render function for notifications. See notify-render()
                render = 'default',
                timeout = 5000,
                --[[
                WARN: Do not remove this line, otherwise the plugin will think
                that there is no background color and it'll throw a bunch of
                errors.
                ]]
                background_colour = '#000000',
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
    use 'tversteeg/registers.nvim'
    use 'junegunn/vim-easy-align'
    use 'andymass/vim-matchup'
    use 'stefandtw/quickfix-reflector.vim'
    use 'ggandor/lightspeed.nvim'
    use 'ron-rs/ron.vim'
    use 'Raimondi/vim-transpose-words'
    use {
        'glacambre/firenvim',
        run = function()
            vim.fn['firenvim#install'](0)
        end,
    }
    -- EWWWWWW
    use 'elkowar/yuck.vim'
end)
