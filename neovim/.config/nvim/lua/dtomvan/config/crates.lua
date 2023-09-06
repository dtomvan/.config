local crates = require('crates')
local cmp = require 'cmp'

local M = {}

local function ld(key)
    return '<leader>c' .. key
end

M.cb = function(ev)
    local opts = { silent = true, buffer = ev.buf }
    cmp.setup.buffer({
        sources = { { name = "crates" } },
    })

    local function desc(desc)
        return vim.tbl_extend('force', opts, {
            desc = desc
        })
    end

    vim.keymap.set('n', ld 't', crates.toggle, desc 'Toggle latest version')
    vim.keymap.set('n', ld 'r', crates.reload, desc 'Reload new versions')

    vim.keymap.set('n', ld 'v', crates.show_versions_popup, desc 'Show versions')
    vim.keymap.set('n', ld 'f', crates.show_features_popup, desc 'Show features')
    vim.keymap.set('n', ld 'd', crates.show_dependencies_popup, desc 'Show dependencies')

    vim.keymap.set('n', ld 'u', crates.update_crate, desc 'Update current crate')
    vim.keymap.set('v', ld 'u', crates.update_crates, desc 'Update selected crates')
    vim.keymap.set('n', ld 'a', crates.update_all_crates, desc 'Update all crates in Cargo.toml')

    vim.keymap.set('n', ld 'e', crates.expand_plain_crate_to_inline_table, desc 'Expand crate')
    vim.keymap.set('n', ld 'E', crates.extract_crate_into_table, desc 'Simplify crate')

    vim.keymap.set('n', ld 'H', crates.open_homepage, desc 'Open homepage')
    vim.keymap.set('n', ld 'R', crates.open_repository, desc 'Open repository')
    vim.keymap.set('n', ld 'D', crates.open_documentation, desc 'Open documentation')
    vim.keymap.set('n', ld 'C', crates.open_crates_io, desc 'Open crates.io for crate')
end

return M
