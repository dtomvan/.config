local M = {}
local previewers = require('telescope.previewers')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local builtin = require('telescope.builtin')

function M.projects()
pickers.new {
  results_title = 'Projects',
  finder = finders.new_oneshot_job({'fd', '--type', 'd'}),
  sorter = sorters.get_fzy_sorter(),
  previewer = previewers.new_termopen_previewer {
    get_command = function(entry)
      return {'ls', entry.value}
    end
  },
  attach_mappings = function(_, map)
      map('i', '<CR>', require('telescopeactions').cd_into_dir)
      return true
    end,
}:find()
end

function M.configs()
pickers.new {
  results_title = 'Fd hidden',
  finder = finders.new_oneshot_job({'fd', '--type', 'd', '--hidden'}),
  sorter = sorters.get_fzy_sorter(),
  previewer = previewers.new_termopen_previewer {
    get_command = function(entry)
      return {'ls', entry.value}
    end
  },
  attach_mappings = function(_, map)
      map('i', '<CR>', actions.cd_into_dir)
      return true
    end,
}:find()
end

function M.buffers()
    builtin.buffers {
      attach_mappings = function(_, map)
          map('n', 'dd', require('telescopeactions').delete_buffer)
          map('i', '<C-d>', require('telescopeactions').delete_buffer)
          map('i', '<M-d>', require('telescopeactions').delete_selected_buffers)
          return true
        end,
    }
end

return M
