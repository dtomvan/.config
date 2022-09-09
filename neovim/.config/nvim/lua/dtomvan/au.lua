local buffer = { buffer = true, noremap = true }
local au = vim.api.nvim_create_autocmd
local group = function(name)
    vim.api.nvim_create_augroup(name, { clear = true })
end

local bp = '*.bin'
local bin = 'Binary'
group(bin)

au('BufReadPre', {
    group = bin,
    pattern = bp,
    callback = function()
        vim.opt.bin = true
    end,
})
au('BufReadPost', {
    group = bin,
    pattern = bp,
    callback = function()
        if vim.opt.bin then
            vim.cmd '%!xxd'
            vim.opt.ft = 'xxd'
        end
    end,
})
au('BufWritePre', {
    group = bin,
    pattern = bp,
    callback = function()
        if vim.opt.bin then
            vim.cmd '%!xxd -r'
        end
    end,
})
au('BufWritePost', {
    group = bin,
    pattern = bp,
    callback = function()
        if vim.opt.bin then
            vim.cmd '%!xxd'
            vim.opt.mod = false
        end
    end,
})

local term = 'Terminal-g'
group(term)
au('TermOpen', {
    group = term,
    callback = function()
        vim.opt.nu = false
        vim.opt.rnu = false
    end,
})

-- group('Formatting')
-- au('BufWritePre', {
--     group = 'Formatting',
--     callback = function()
--         if not vim.tbl_isempty(vim.lsp.buf_get_clients()) then
--             vim.lsp.buf.format { async = false }
--         end
--     end,
-- })

local regels = 'Regels.md'
group(regels)
au('BufWritePre', {
    group = regels,
    callback = function()
        if vim.fn.expand '%:p' == '/home/tomvd/regels.md' then
            local line = 'Laatst bijgewerkt op: ' .. os.date '%F %T'
            vim.api.nvim_buf_set_lines(0, -2, -1, false, { line })
        end
    end,
})

group 'TextYankHighlight'
au('TextYankPost', {
    group = 'TextYankHighlight',
    callback = function()
        vim.highlight.on_yank { on_visual = false }
    end,
})

if vim.fn.has 'nvim-0.8' == 1 then
    local winbar = 'UserWinbar'
    group(winbar)
    au({ 'BufWinEnter', 'WinEnter' }, {
        group = winbar,
        callback = function()
            local winbar_exclude = {
                '',
                'alpha',
                'dap-repl',
                'dap-terminal',
                'dapui_breakpoints',
                'dapui_console',
                'dapui_scopes',
                'dapui_stacks',
                'dapui_watches',
                'dashboard',
                'DressingSelect',
                'DressingInput',
                'harpoon',
                'help',
                'Jaq',
                'lab',
                'lir',
                'Markdown',
                'neogitstatus',
                'notify',
                'NvimTree',
                'Outline',
                'packer',
                'spectre_panel',
                'startify',
                '[Scratch]',
                'toggleterm',
                'Trouble',
            }
            vim.schedule(function()
                if vim.tbl_contains(winbar_exclude, vim.bo.filetype) then
                    return
                end
                vim.wo.winbar = require('dtomvan.utils').winbar()
            end)
        end,
    })
end
