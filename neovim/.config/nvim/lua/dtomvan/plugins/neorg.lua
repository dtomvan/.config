return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        cmd = 'Neorg',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neorg/neorg-telescope",
        },
        config = function(_, opts)
            require('neorg').setup(opts)
            local callbacks = require("neorg.core.callbacks")

            callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
                keybinds.map_event_to_mode("norg", {
                    n = {
                        { "<C-s>", "core.integrations.telescope.find_linkable" },
                    },
                    i = {
                        { "<C-l>", "core.integrations.telescope.insert_link" },
                    },
                }, {
                    silent = true,
                    noremap = true,
                })
            end)
        end,
        opts = function()
            local neorg = require 'neorg.core'
            local config, utils = neorg.config, neorg.utils

            local function timestamp()
                return os.date '%F %T'
            end

            return {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            default_workspace = "notes",
                        },
                    },
                    ["core.integrations.telescope"] = {},
                    ["core.completion"] = {
                        config = {
                            engine = 'nvim-cmp',
                        },
                    },
                    ["core.summary"] = {},
                    ["core.presenter"] = {
                        config = {
                            zen_mode = 'zen-mode',
                        },
                    },
                    ["core.export"] = {},
                    ["core.export.markdown"] = {},
                    ["core.esupports.metagen"] = {
                        config = {
                            type = 'empty',
                            template = {
                                { "title",       function() return vim.fn.expand("%:p:t:r") end },
                                { "description", "" },
                                { "authors",     "Tom van Dijk" },
                                { "categories",  "[]" },
                                { "created",     timestamp },
                                { "updated",     timestamp },
                                { "version",     function() return config.norg_version end },
                            },
                        },
                    },
                },
            }
        end,
    }
}
