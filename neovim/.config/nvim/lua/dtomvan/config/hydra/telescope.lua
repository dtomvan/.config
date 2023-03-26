-- https://github.com/anuvyklack/hydra.nvim/wiki/Telescope
local cmd = require 'dtomvan.config.hydra'.key_cmd

local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _r_: resume      _u_: undotree
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

return {
    name = 'Telescope',
    hint = hint,
    config = {
        color = 'teal',
        invoke_on_body = true,
        hint = {
            position = 'middle',
            border = 'rounded',
        },
    },
    mode = 'n',
    body = '<leader>T',
    heads = {
        { 'f', cmd 'Telescope find_files' },
        { 'g', cmd 'Telescope live_grep' },
        { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
        { 'h', cmd 'Telescope help_tags', { desc = 'vim help' } },
        { 'm', cmd 'MarksListBuf', { desc = 'marks' } },
        { 'k', cmd 'Telescope keymaps' },
        { 'O', cmd 'Telescope vim_options' },
        { 'r', cmd 'Telescope resume' },
        { 'p', cmd 'Telescope projects', { desc = 'projects' } },
        {
            '/',
            cmd 'Telescope current_buffer_fuzzy_find',
            { desc = 'search in file' },
        },
        { '?', cmd 'Telescope search_history', { desc = 'search history' } },
        {
            ';',
            cmd 'Telescope command_history',
            { desc = 'command-line history' },
        },
        { 'c', cmd 'Telescope commands', { desc = 'execute command' } },
        {
            'u',
            cmd 'silent! %foldopen! | UndotreeToggle',
            { desc = 'undotree' },
        },
        {
            '<Enter>',
            cmd 'Telescope',
            { exit = true, desc = 'list all pickers' },
        },
        { '<Esc>', nil, { exit = true, nowait = true } },
    },
}
