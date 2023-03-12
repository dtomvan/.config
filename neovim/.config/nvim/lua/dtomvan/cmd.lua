local cmd = vim.api.nvim_create_user_command
local system = vim.fn.system
local flags = require 'dtomvan.rg_flags'
local noremap = require('dtomvan.keymaps').noremap

cmd('Rg', function(i)
    local args = i.args
    local result = system('rg -n --column ' .. args)
    local items = {}
    for res in vim.gsplit(result, '\n') do
        local filename, lnum, col, text =
            string.match(res, '(.+):(%d+):(%d+):(.+)')
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
    vim.cmd.cope()
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

local function bail(msg)
    vim.notify(msg, vim.log.levels.ERROR)
end

cmd('Scratch', function(_)
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
                table.insert(
                    scratch_files,
                    string.sub(filename, #scratch_dir + 1)
                )
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
            vim.cmd.edit(string.format('%s%s', scratch_dir, a))
            vim.cmd.Mkdir()
        end
    end)
end, { desc = 'Create new scratch file in ~/.config/nvim', force = true })

local function thisft()
    local home = os.getenv 'HOME'
    if not home then
        return bail 'Cannot find home dir'
    end
    local ftplugindir = string.format('%s/.config/nvim/ftplugin', home)
    vim.fn.mkdir(ftplugindir, 'p')
    local has_lua = false
    local has_vim = false
    local cur_ft = vim.bo.filetype
    for filename in vim.fs.dir(ftplugindir) do
        if string.match(filename, '^' .. cur_ft .. '%.lua') then
            has_lua = true
            break
        elseif string.match(filename, '^' .. cur_ft .. '%.vim') then
            has_vim = true
            break
        end
    end
    if has_vim and not has_lua then
        vim.cmd.edit(string.format('%s/%s.vim', ftplugindir, cur_ft))
        return
    end
    vim.cmd.edit(string.format('%s/%s.lua', ftplugindir, cur_ft))
    vim.cmd.Mkdir()
end

cmd('GoFt', thisft, { desc = 'Open current ftplugin', force = true })
vim.keymap.set(
    'n',
    '<space>gft',
    thisft,
    noremap 'Open ftplugin for current :set filetype'
)

cmd('Temple', function()
    vim.cmd [[colorscheme templeos]]
end, { desc = 'Reboot into TempleOS', force = true })

cmd('Loc', function(args)
    if args.bang then
        vim.cmd.vsp 'term://loc --files'
    else
        vim.cmd.vsp 'term://loc'
    end
    vim.cmd 'vert res 82'
end, { desc = 'run loc in a terminal', force = true, bang = true })

local function hi_there(i)
    local out = vim.fn.trim(vim.fn.execute('hi ' .. i.args))
    print(out)
    if string.find(out, 'links to') then
        local a = vim.fn.split(out, ' ')
        hi_there { args = a[#a] }
    end
end

cmd('Hit', hi_there, {
    desc = 'Follow highlights automatically',
    nargs = 1,
    complete = 'highlight',
    force = true,
})

cmd('Reconfuse', function()
    _G.confusing_maps = true
end, { desc = 'Remove confusing map', force = true })

cmd('Unconfuse', function()
    _G.confusing_maps = false
end, { desc = 'Remove confusing map', force = true })

cmd('Confusing', function()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.cmd.vs()
    vim.cmd.buffer(bufnr)
    for k, v in pairs(_G.confusing_maps_set) do
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, {
            string.format(
                '%s: %s described as %s',
                k,
                v.map,
                v.desc or 'nothing'
            ),
        })
    end
end, { desc = 'Show confusing mappings', force = true })

-- Weird abbreviation I got used to
vim.cmd.noreabbrev('fcd', 'cd %:p:h')

cmd('DiffOrig', function()
    local start = vim.api.nvim_get_currentbuf()
    vim.cmd 'vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis'

    local scratch = vim.api.nvim_get_current_buf()
    vim.cmd 'wincmd p | diffthis'
    for _, buf in ipairs { scratch, start } do
        vim.keymap.set('n', 'q', function()
            vim.api.nvim_buf_delete(scratch, { force = true })
            vim.keymap.del('n', 'q', { buffer = start })
        end, { buffer = buf })
    end
end, { desc = 'Diff current life with version before last save' })
