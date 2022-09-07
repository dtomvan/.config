local uv = vim.loop
local cmd = vim.api.nvim_create_user_command
local system = vim.fn.system
local flags = require 'dtomvan.rg_flags'

cmd('Rg', function(i)
    local args = i.args
    local result = system('rg -n --column ' .. args)
    local items = {}
    for res in vim.gsplit(result, '\n') do
        local filename, lnum, col, text = string.match(res, '(.+):(%d+):(%d+):(.+)')
        -- check if the line isn't a context line
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
    EX.cope()
end, {
    nargs = '+',
    force = true,
    desc = 'Open ripgrep output in the quickfix list.',
    complete = function(lead, _, _)
        local possible = {}
        for _, flag in ipairs(flags) do
            if vim.startswith(flag, lead) then
                table.insert(possible, flag)
            end
        end
        return possible
    end,
})

cmd('Scratch', function(_)
    local function bail(msg)
        vim.notify(msg, vim.log.levels.ERROR)
    end

    local home = os.getenv 'HOME'
    if not home then
        return bail 'Cannot find home dir'
    end
    local scratch_dir = string.format('%s/.config/nvim/scratch/', home)
    vim.fn.mkdir(scratch_dir, 'p')

    local scratch_files = {}
    for filename in vim.gsplit(system('fd --type f . ' .. scratch_dir), '\n') do
        if type(filename) == 'string' then
            if #filename > 0 then
                table.insert(scratch_files, string.sub(filename, #scratch_dir + 1))
            end
        end
    end
    table.sort(scratch_files)

    _G.scratch_comp = function(lead, _, _)
        local possible = {}
        for _, file in ipairs(scratch_files) do
            if vim.startswith(file, lead) then
                table.insert(possible, file)
            end
        end
        return possible
    end

    vim.ui.input({
        prompt = 'Scratch filename -> ',
        completion = 'customlist,v:lua.scratch_comp',
    }, function(a)
        if a then
            EX.edit(string.format('%s/%s', scratch_dir, a))
            EX.Mkdir()
        end
    end)
end, { desc = 'Create new scratch file in ~/.config/nvim', force = true })
