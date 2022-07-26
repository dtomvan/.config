local buffer = { buffer = true, noremap = true }
local au = vim.api.nvim_create_autocmd
local gops = { clear = true }
local group = function(name)
    vim.api.nvim_create_augroup(name, gops)
end

local bp = '*.bin'
local bin = group 'Binary'

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

local term = group 'Terminal-g'
au('TermOpen', {
    group = term,
    callback = function()
        vim.opt.nu = false
        vim.opt.rnu = false
    end,
})

local rsp = '*.rs'
local rs = group 'RustBufs'
au('BufEnter', {
    pattern = rsp,
    callback = function()
        vim.keymap.set('n', 'J', require('rust-tools.join_lines').join_lines, buffer)
        vim.keymap.set('n', '<leader>l', require('rust-tools.hover_actions').hover_actions, buffer)
        vim.keymap.set('n', '<leader>t', require('rust-tools.open_cargo_toml').open_cargo_toml, buffer)
    end,
    group = rs,
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

local regels = group 'Regels.md'
au('BufWritePre', {
    group = regels,
    callback = function()
        if vim.fn.expand '%:p' == '/home/tomvd/regels.md' then
            local line = 'Laatst bijgewerkt op: ' .. os.date '%F %T'
            vim.api.nvim_buf_set_lines(0, -2, -1, false, { line })
        end
    end,
})

local hsp = '*.hs'
local hs = group 'HaskBufs'
au('BufEnter', {
    pattern = hsp,
    callback = function()
        vim.keymap.set('n', '<leader>sb', '<cmd>vs term://stack build<cr>', buffer)
    end,
    group = hs,
})

local help = group 'vim help'
au('FileType', {
    pattern = 'help',
    group = help,
    callback = function()
        vim.wo.nu = true
        vim.wo.rnu = true
    end,
})

group 'TextYankHighlight'
au('TextYankPost', {
    group = 'TextYankHighlight',
    callback = function()
        vim.highlight.on_yank { on_visual = false }
    end,
})

local mda = group 'MarkdownAlign'
au('FileType', {
    group = mda,
    pattern = 'markdown',
    callback = function()
        vim.keymap.set('v', '<Leader><bslash>', ':EasyAlign*<bar><cr>', {
            buffer = true,
            remap = true,
            silent = true,
        })
    end,
})

local commit = '*/COMMIT_EDITMSG'
local git = group 'GitCommitMsg'
au('BufEnter', {
    group = git,
    pattern = commit,
    callback = function()
        vim.keymap.set('n', '<leader>0', function()
            local linenr = vim.fn.search('# Please enter the commit message', 'n')
            if linenr == 0 then
                return
            end
            local date = os.date '%F'
            vim.api.nvim_buf_set_lines(0, 0, linenr - 1, true, { date })
        end, { buffer = true, silent = true })
    end,
})

if vim.fn.has 'nvim-0.8' == 1 then
    local winbar = group 'WinBar'
    au('BufEnter', {
        group = winbar,
        callback = function()
            local winbar_exclude = {
                'help',
                'packer',
                'neogitstatus',
                'NvimTree',
                'Trouble',
                'alpha',
                'lir',
                'Outline',
                'spectre_panel',
                'toggleterm',
            }
            if vim.tbl_contains(winbar_exclude, vim.bo.filetype) then
                vim.wo.winbar = nil
            end
        end,
    })
end
