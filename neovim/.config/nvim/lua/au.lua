local buffer = { buffer = true, noremap = true }
local group = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd
local gops = { clear = true }

local bp = '*.bin'
local bin = 'Binary'
group(bin, gops)

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
group(term, gops)
au('TermOpen', {
    group = term,
    callback = function()
        vim.opt.nu = false
        vim.opt.rnu = false
    end,
})

local rsp = '*.rs'
local rs = 'RustBufs'
group(rs, gops)
au('BufEnter', {
    pattern = rsp,
    callback = function()
        vim.keymap.set('n', 'J', require('rust-tools.join_lines').join_lines, buffer)
        vim.keymap.set('n', '<leader>l', require('rust-tools.hover_actions').hover_actions, buffer)
        vim.keymap.set('n', '<leader>t', require('rust-tools.open_cargo_toml').open_cargo_toml, buffer)
    end,
    group = rs,
})

-- group('Formatting', gops)
-- au('BufWritePre', {
--     group = 'Formatting',
--     callback = function()
--         vim.lsp.buf.formatting()
--     end,
-- })

group('Regels.md', gops)
au('BufWritePre', {
    group = 'Regels.md',
    callback = function()
        if vim.fn.expand '%:p' == '/home/tomvd/regels.md' then
            local line = 'Laatst bijgewerkt op: ' .. os.date '%F %T'
            vim.api.nvim_buf_set_lines(0, -2, -1, false, { line })
        end
    end,
})

local hsp = '*.hs'
local hs = 'HaskBufs'
group(hs, gops)
au('BufEnter', {
    pattern = hsp,
    callback = function()
        vim.keymap.set('n', '<leader>sb', '<cmd>vs term://stack build<cr>', buffer)
    end,
    group = hs,
})

local help = 'vim help'
group(help, gops)
au('FileType', {
    pattern = 'help',
    callback = function()
        vim.wo.nu = true
        vim.wo.rnu = true
    end,
    group = help,
})

group('TextYankHighlight', gops)
au('TextYankPost', {
    group = "TextYankHighlight",
    callback = function()
        vim.highlight.on_yank { on_visual = false }
    end,
})
