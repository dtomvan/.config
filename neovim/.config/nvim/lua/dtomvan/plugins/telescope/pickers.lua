local M = {}
local previewers = require 'telescope.previewers'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local builtin = require 'telescope.builtin'
local actions = R 'dtomvan.plugins.telescope.actions'

local function preview_list(entry)
    return { 'ls', entry.value }
end

function M.projects()
    pickers.new({
        prompt_title = 'Projects',
        finder = finders.new_oneshot_job({ 'fd', '--type', 'd' }, {}),
        previewer = previewers.new_termopen_previewer {
            get_command = preview_list,
        },
        attach_mappings = function(_, map)
            map('i', '<CR>', actions.cd_into_dir)
            return true
        end,
    }, {}):find()
end

function M.configs()
    pickers.new({
        prompt_title = 'Fd hidden',
        finder = finders.new_oneshot_job({ 'fd', '--type', 'd', '--hidden' }, {}),
        previewer = previewers.new_termopen_previewer {
            get_command = preview_list,
        },
        attach_mappings = function(_, map)
            map('i', '<CR>', actions.cd_into_dir)
            return true
        end,
    }, {}):find()
end

function M.buffers()
    builtin.buffers {
        attach_mappings = function(_, map)
            map('n', 'dd', actions.delete_buffer)
            map('n', 'c', actions.create_buffer)
            map('i', '<C-d>', actions.delete_buffer)
            map('i', '<M-d>', actions.delete_selected_buffers)
            map('i', '<M-n>', actions.create_buffer)
            return true
        end,
    }
end

function M.dotfiles()
    builtin.git_files {
        prompt_title = 'Dotfiles',
        cwd = '~/DotFiles',
        attach_mappings = function(_, map)
            map('i', '<CR>', actions.edit_and_cd)
            return true
        end,
    }
end

function M.grep()
    builtin.live_grep()
end

function M.current_buffer()
    builtin.current_buffer_fuzzy_find()
end

function M.diagnostics()
    builtin.diagnostics {
        ---@diagnostic disable-next-line: unused-local
        attach_mappings = function(_, map)
            -- BUG: doesn't refresh
            -- map('i', '<C-t>', trouble.open_with_trouble)
            return true
        end,
    }
end

return M
