local M = {}
local previewers = require 'telescope.previewers'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local builtin = require 'telescope.builtin'

function M.projects()
    pickers.new({
        results_title = 'Projects',
        finder = finders.new_oneshot_job { 'fd', '--type', 'd' },
        previewer = previewers.new_termopen_previewer {
            get_command = function(entry)
                return { 'ls', entry.value }
            end,
        },
        attach_mappings = function(_, map)
            map('i', '<CR>', R('telescopeactions').cd_into_dir)
            return true
        end,
    }):find()
end

function M.configs()
    pickers.new({
        results_title = 'Fd hidden',
        finder = finders.new_oneshot_job { 'fd', '--type', 'd', '--hidden' },
        previewer = previewers.new_termopen_previewer {
            get_command = function(entry)
                return { 'ls', entry.value }
            end,
        },
        attach_mappings = function(_, map)
            map('i', '<CR>', R('telescopeactions').cd_into_dir)
            return true
        end,
    }):find()
end

function M.buffers()
    builtin.buffers {
        attach_mappings = function(_, map)
            map('n', 'dd', R('telescopeactions').delete_buffer)
            map('n', 'c', R('telescopeactions').create_buffer)
            map('i', '<C-d>', R('telescopeactions').delete_buffer)
            map('i', '<M-d>', R('telescopeactions').delete_selected_buffers)
            map('i', '<M-n>', R('telescopeactions').create_buffer)
            return true
        end,
    }
end

function M.dotfiles()
    builtin.git_files {
        cwd = '~/DotFiles',
    }
end

function M.grep()
    builtin.live_grep()
end

return M
