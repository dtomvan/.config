local transform_mod = require('telescope.actions.mt').transform_mod
local tele_actions = require('telescope.actions')

local actions = {}

function actions.cd_into_dir(prompt_bufnr)
    local dir = tele_actions.get_selected_entry(prompt_bufnr).value
    tele_actions.close(prompt_bufnr)
    vim.fn.execute("cd " .. dir, "silent")
    require('telescope.builtin').find_files()
    vim.fn.execute("normal i")
end

function actions.delete_buffer(prompt_bufnr)
    local buffer = tele_actions.get_selected_entry(prompt_bufnr).bufnr
    vim.fn.execute("bd " .. buffer)
end

return transform_mod(actions)
