local Process = require 'dtomvan.utils.proc'.Process
local rwds = vim.iter(Process:new(vim.fn.getpid() or 1):parents())
    :find(function(x)
        return vim.fs.basename(x:resolved_cmdline()[1]) == 'rwds-cli'
    end)
vim.g.is_rwds = rwds and true or false

if not vim.g.is_rwds then return end

local lasttime
vim.api.nvim_create_autocmd({ 'BufAdd', 'BufLeave' }, {
    group = vim.api.nvim_create_augroup('RwdsStayInCorrectBuffer', { clear = true }),
    callback = function(ev)
        if lasttime then
            if vim.uv.now - lasttime < 500 then
                return
            end
        end
        vim.notify('Do not open different buffers in a RWDS session', vim.log.levels.WARN)
        if ev.event == 'BufAdd' then
            vim.api.nvim_buf_delete(ev.buf, { force = true })
        end
        vim.cmd [[ only | if tabpagenr('$') > 1 | then | tabonly | endif | b ~/.local/share/rusty-words/temp.tsv ]]
        lasttime = vim.uv.now()
    end
})

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
