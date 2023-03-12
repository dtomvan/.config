local silent = require('dtomvan.keymaps').silent

local ls = require 'luasnip'
local types = require 'luasnip.util.types'
local ft_fns = require 'luasnip.extras.filetype_functions'

require('luasnip.loaders.from_vscode').lazy_load()

vim.keymap.set('i', '<C-k>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, silent 'Expand snippet')

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, silent 'Cycle between choices in choice node')

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    require('luasnip').jump(-1)
end, silent 'Jump back')

vim.keymap.set('s', '<c-k>', function()
    require('luasnip').jump(1)
end, silent 'Jump forward')

require('luasnip.loaders.from_lua').lazy_load {
    paths = './lua/dtomvan/config/luasnip/',
}

ls.config.set_config {
    history = true,
    update_events = 'TextChanged,TextChangedI',
    delete_check_events = 'TextChanged,InsertLeave',
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { '●', 'DiagnosticWarn' } },
            },
        },
        [types.insertNode] = {
            active = {
                virt_text = { { '●', 'DiagnosticHint' } },
            },
        },
        -- [types.choiceNode] = {
        --     active = {
        --         virt_text = { { 'choiceNode', 'Comment' } },
        --     },
        -- },
    },
    store_selection_keys = '<Tab>',
    ft_func = ft_fns.from_cursor,
    enable_autosnippets = true,
}
