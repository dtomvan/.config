local home = vim.fn.expand '~'
local vault_path = home .. "/projects/02-ideas-notes/dtomvan-vault/"
local vault_glob = vault_path .. "**.md"

return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    event = {
        "BufReadPre " .. vault_glob,
        -- "BufNewPre " .. vault_glob,
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = vault_path,
            },
        },
        notes_subdir = '05 - Fleeting',
        daily_notes = {
            folder = "06 - Daily",
            date_format = "%Y-%m-%d",
            alias_format = "%B %-d, %Y",
            template = "99 - Meta/00 - Templates/(TEMPLATE) Daily.md",
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        new_notes_location = "notes_subdir",
        use_advanced_uri = true,
        open_app_foreground = true,
    },
}
