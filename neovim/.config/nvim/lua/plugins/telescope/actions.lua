local transform_mod = require('telescope.actions.mt').transform_mod
local tele_actions = require 'telescope.actions'
local actions_state = require 'telescope.actions.state'

local actions = {}

function actions.cd_into_dir(prompt_bufnr)
    local dir = actions_state.get_selected_entry().value
    tele_actions.close(prompt_bufnr)
    vim.fn.chdir('cd ' .. dir)
end

function actions.edit_and_cd(prompt_bufnr)
    local picker = actions_state.get_current_picker(prompt_bufnr)
    local file = actions_state.get_selected_entry().value

    tele_actions.close(prompt_bufnr)
    vim.cmd('e ' .. picker.cwd .. '/' .. file)
    vim.fn.chdir(vim.fn.expand '%:p:h')
end

function actions.delete_buffer(prompt_bufnr)
    local buffer = actions_state.get_selected_entry().bufnr
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
