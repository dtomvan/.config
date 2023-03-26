local au = vim.api.nvim_create_autocmd
local group = function(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

local formatter = require 'dtomvan.formatter'

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

local term = 'Terminal-g'
group(term)
au('TermOpen', {
    group = term,
    callback = function()
        vim.opt.nu = false
        vim.opt.rnu = false
    end,
})

au('BufWritePre', {
    group = group 'Formatting',
    callback = function(o)
        if not vim.api.nvim_buf_get_option(o.buf, 'modified') then
            return
        end
        if formatter.do_format_on_save(o.buf) then
            formatter.format_buf(o.buf)
        end
    end,
})

au('BufWritePre', {
    group = group 'Regels.md',
    callback = function()
        if vim.fn.expand '%:p' == '/home/tomvd/regels.md' then
            local line = 'Laatst bijgewerkt op: ' .. os.date '%F %T'
            vim.api.nvim_buf_set_lines(0, -2, -1, false, { line })
        end
    end,
})

au('TextYankPost', {
    group = group 'TextYankHighlight',
    callback = function()
        vim.highlight.on_yank { on_visual = false }
    end,
})

if vim.fn.has 'nvim-0.8' == 1 then
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
        'starter',
        'startify',
        '[Scratch]',
        'toggleterm',
        'Trouble',
    }
    au({ 'BufWinEnter', 'WinEnter' }, {
        group = group 'UserWinbar',
        callback = function()
            vim.schedule(function()
                if vim.g._no_winbar or vim.g.started_by_firenvim then
                    return
                end
                local cfg = vim.api.nvim_win_get_config(0)
                if cfg.relative > '' or cfg.external then
                    return ''
                end
                if vim.tbl_contains(winbar_exclude, vim.bo.filetype) then
                    return
                end
                vim.wo.winbar = require('dtomvan.utils').winbar()
            end)
        end,
    })
end

au('BufReadPost', {
    group = group 'LastPlace',
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

if vim.g.started_by_firenvim then
    au('BufReadPost', {
        group = group 'FireNvimOldFiles',
        callback = function(ev)
            vim.fn.filter(vim.v.oldfiles, 'v:val !=# "' .. ev.file .. '"')
        end,
    })
end

au({ 'BufWritePre' }, {
    group = group 'auto_create_dir',
    callback = function(ev)
        vim.fn.mkdir(vim.fn.fnamemodify(ev.file, ':p:h'), 'p')
    end,
})

au('FileType', {
    group = group 'jqfile',
    pattern = 'jq',
    callback = function(ev)
        vim.schedule(function()
            vim.api.nvim_buf_set_lines(ev.buf, 0, 0, false, { '# jq script' })
            vim.api.nvim_buf_set_lines(
                ev.buf,
                -1,
                -1,
                false,
                -- Hehe, otherwise vim actually reads the modeline
                -- it sets `filetype` to `jq`
                { '\x23\x20\x76\x69\x6d\x3a\x66\x74\x3d\x6a\x71' }
            )
        end)
    end,
})
