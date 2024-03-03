local utils = require 'dtomvan.utils'
local rwds = utils.our_parents('rwds-cli')
vim.g.is_rwds = #rwds > 0

if not vim.g.is_rwds then return end

vim.api.nvim_create_user_command('Swap', function()
    local res = {}
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
        table.insert(res,
            table.concat(
                vim.iter(
                    vim.split(line, '\t', { plain = true, trimempty = false })
                ):rev():totable(),
                '\t'
            ))
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, res)
end, { desc = 'Swap columns in TSV file' })

vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    once = true,
    callback = function()
        local nope = function()
            return vim.notify('Lazypack has been disabled, only colorscheme loaded for RWDS sessions.',
                vim.log.level.WARN)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        require 'lazy.view.commands'.cmd = nope
        vim.api.nvim_create_user_command('Lazy', nope, { force = true })
        require 'noice'.notify(('RWDS session with args %s'):format(vim.inspect(vim.list_slice(rwds.cmdline, 2))),
            vim.log.levels.INFO)
    end
})

vim.keymap.set('n', '<c-q>', vim.cmd.wqall, { buffer = true })

local function setops(bufid, winid)
    if (bufid and winid) or (not bufid and not winid) then error('invalid args') end
    local o = { buf = bufid, win = winid }
    if o.win then
        vim.api.nvim_set_option_value('scrolloff', 10, o)
    end
    if o.buf then
        vim.api.nvim_set_option_value('tabstop', 20, o)
    end
end

for _, bufid in ipairs(vim.api.nvim_list_bufs()) do
    setops(bufid)
end

for _, winid in ipairs(vim.api.nvim_list_wins()) do
    setops(nil, winid)
end

vim.api.nvim_create_autocmd('BufAdd', {
    callback = function(o)
        setops(o.buf)
    end
})

for _, i in ipairs { 'j', 'k' } do
    vim.keymap.set('n', i, i .. 'zz')
end
