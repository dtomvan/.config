local cmd = vim.api.nvim_create_user_command
local system = vim.fn.system

cmd('Rg', function(i)
    local args = i.args
    local result = system('rg -n --column ' .. args)
    local items = {}
    for res in vim.gsplit(result, '\n') do
        local filename, lnum, col, text = string.match(res, '(.+):(%d+):(%d+):(.+)')
        -- Check if the line isn't a context line
        if filename then
            local item = {
                filename = filename,
                lnum = lnum,
                text = text,
                col = col,
            }
            table.insert(items, item)
        end
    end
    vim.fn.setqflist({}, ' ', { title = 'rg ' .. args, items = items })
    vim.cmd 'cope'
end, {
    nargs = '+',
    force = true,
    desc = 'Open ripgrep output in the quickfix list.',
    complete = function(lead, _, _)
        local flags = require 'rg_flags'
        local possible = {}
        for _, flag in ipairs(flags) do
            if vim.startswith(flag, lead) then
                table.insert(possible, flag)
            end
        end
        return possible
    end,
})
