local transform_mod = require('telescope.actions.mt').transform_mod
local tele_actions = require 'telescope.actions'
local actions_state = require 'telescope.actions.state'

local actions = {}

function actions.cd_into_dir(prompt_bufnr)
    local dir = tele_actions.get_selected_entry().value
    tele_actions.close(prompt_bufnr)
    vim.fn.execute('cd ' .. dir, 'silent')
    -- require('telescope.builtin').find_files()
    -- vim.fn.execute("normal i")
end

function actions.delete_buffer(prompt_bufnr)
    local buffer = tele_actions.get_selected_entry().bufnr
    vim.fn.execute('bd! ' .. buffer)
    tele_actions.remove_selection(prompt_bufnr)
    tele_actions.close(prompt_bufnr)
    R('telescopepickers').buffers()
    vim.fn.execute 'normal i'
end

function actions.delete_selected_buffers(prompt_bufnr)
    local picker = actions_state.get_current_picker(prompt_bufnr)

    for _, entry in ipairs(picker:get_multi_selection()) do
        vim.fn.execute('bd! ' .. entry.bufnr)
    end
    tele_actions.close(prompt_bufnr)
    R('telescopepickers').buffers()
    vim.fn.execute 'normal i'
end

function actions.create_buffer(prompt_bufnr)
    tele_actions.close(prompt_bufnr)
    vim.fn.execute 'new | close'
    R('telescopepickers').buffers()
    vim.fn.execute 'normal i'
end

return transform_mod(actions)
