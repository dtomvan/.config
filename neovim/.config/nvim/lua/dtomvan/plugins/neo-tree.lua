local buf = require 'dtomvan.utils.buf'
local utils = require 'dtomvan.utils'

local function autoremove()
    local cur = buf:from_current()
    if #vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).relative == ""
        end, vim.api.nvim_tabpage_list_wins(0)) == 1
        and cur.bo.ft == 'neo-tree' then
        cur:delete()
        buf:create { scratch = true, listed = true }:goto()
    end
end

return {
    'nvim-neo-tree/neo-tree.nvim',
    version = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-tree/nvim-web-devicons', name = 'nvim-tree-devicons' },
        'MunifTanjim/nui.nvim',
        {
            's1n7ax/nvim-window-picker',
            event = 'VeryLazy',
            name = 'window-picker',
            version = '2.*',
            opts = {
                hint = 'floating-big-letter',
            },
        },
    },
    cmd = 'Neotree',
    keys = {
        { '<leader>bl',  '<cmd>Neotree toggle float show buffers<cr>', silent = true },
        { '<leader>gss', '<cmd>Neotree toggle float git_status<cr>',   silent = true },
        { '<f1>',        '<cmd>Neotree toggle reveal right<cr>',       silent = true },
        { '<leader>pv',  '<cmd>Neotree focus reveal right<cr>',        silent = true },
        { '<leader>nt',  ':Neotree toggle reveal right ' },
    },
    init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        vim.fn.sign_define(
            'DiagnosticSignError',
            { text = ' ', texthl = 'DiagnosticSignError' }
        )
        vim.fn.sign_define(
            'DiagnosticSignWarn',
            { text = ' ', texthl = 'DiagnosticSignWarn' }
        )
        vim.fn.sign_define(
            'DiagnosticSignInfo',
            { text = ' ', texthl = 'DiagnosticSignInfo' }
        )
        vim.fn.sign_define(
            'DiagnosticSignHint',
            { text = '', texthl = 'DiagnosticSignHint' }
        )
    end,
    opts = {
        event_handlers = {
            {
                event = "vim_win_closed",
                handler = autoremove,
            }
        },
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
        use_libuv_file_watcher = true,
        follow_current_file = true,
        source_selector = {
            winbar = false,
            statusline = false,
        },
    },
}
