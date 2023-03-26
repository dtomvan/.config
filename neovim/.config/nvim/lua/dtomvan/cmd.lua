local utils = require 'dtomvan.utils.tables'
local formatter = require 'dtomvan.formatter'
local flags = require 'dtomvan.rg_flags'
local noremap = require('dtomvan.keymaps').noremap

local cmd = vim.api.nvim_create_user_command
local system = vim.fn.system

cmd('Rg', function(params)
    local overseer = require 'overseer'

    local args = vim.fn.expandcmd(params.args)
    local command, num_subs = vim.o.grepprg:gsub('%$%*', args)

    if num_subs == 0 then
        command = command .. ' ' .. args
    end
    local task = overseer.new_task {
        cmd = command,
        name = 'grep ' .. args,
        components = {
            {
                'on_output_quickfix',
                errorformat = vim.o.grepformat,
                open = not params.bang,
                open_height = 8,
                items_only = true,
            },
            { 'on_complete_dispose', timeout = 30 },
            'default',
        },
    }
    task:start()
end, {
    bang = true,
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

    vim.ui.input({
        prompt = 'Scratch filename -> ',
        completion = function(lead)
            return vim.tbl_filter(function(x)
                return vim.startswith(x, lead)
            end, scratch_files)
        end,
    }, function(a)
        if a then
            vim.cmd.edit(string.format('%s%s', scratch_dir, a))
            vim.cmd.Mkdir()
        end
    end)
end, { desc = 'Create new scratch file in ~/.config/nvim', force = true })

vim.api.nvim_create_user_command('Make', function(params)
    local task = require('overseer').new_task {
        cmd = vim.split(vim.o.makeprg, '%s+'),
        args = params.fargs,
        components = {
            { 'on_output_quickfix', open = not params.bang, open_height = 8 },
            'default',
        },
    }
    task:start()
end, {
    desc = '',
    nargs = '*',
    bang = true,
})

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

cmd('Start', function()
    if type(MiniStarter) == 'table' then
        pcall(MiniStarter.open)
    else
        vim.notify('MiniStarter not found', vim.log.levels.ERROR)
    end
end, { desc = 'Open MiniStarter' })

cmd('AutopairsToggle', function()
    local npairs = require 'nvim-autopairs'
    if npairs.state.disabled then
        npairs.enable()
        vim.notify 'Enabled autopairs'
    else
        npairs.disable()
        vim.notify 'Disabled autopairs'
    end
end, { desc = 'Toggle auto pairs' })

local function clients_comp(lead)
    return utils.get_filter_startswith(
        formatter.get_formatting_clients {
            bufnr = vim.api.nvim_get_current_buf(),
        },
        'name',
        lead
    )
end

cmd('Formatter', function(o)
    local cl, multiple = formatter.buf_get_server(
        tonumber(o.args) or vim.api.nvim_get_current_buf()
    )
    if not cl then
        return vim.notify 'no formatter for this buffer'
    end
    if multiple then
        vim.notify(vim.inspect(utils.map_get(cl, 'name')))
    else
        vim.notify(cl.name)
    end
end, { desc = 'Get current formatter for buffer', nargs = '?' })

cmd('SetFormatter', function(o)
    local bufnr = vim.api.nvim_get_current_buf()
    local name = o.args
    local clients =
        formatter.get_formatting_clients { bufnr = bufnr, name = name }
    if not vim.tbl_isempty(clients) or o.bang then
        formatter.set_server(bufnr, name)
    else
        vim.notify('No such client attached: ' .. name, vim.log.levels.ERROR)
    end
end, {
    desc = 'Set formatter for current buffer',
    nargs = 1,
    bang = true,
    complete = clients_comp,
})

cmd('SaveFormatter', function(o)
    local bufnr = vim.api.nvim_get_current_buf()
    local ok, err = pcall(formatter.save_ft_server, bufnr, o.fargs[1], true)
    if not ok then
        vim.notify(
            ("Couldn't save formatter: %s"):format(err),
            vim.log.levels.ERROR
        )
    end
end, {
    desc = 'Save formatter for current filetype to config file',
    nargs = 1,
    complete = clients_comp,
})

cmd('ReloadFormatters', function()
    local ok, err = pcall(formatter.load_ft_servers)
    if not ok then
        vim.notify(
            ("Couldn't load formatters: %s"):format(err),
            vim.log.levels.ERROR
        )
    end
end, { desc = 'Reload formatters from config file' })

for _, action in ipairs { 'disable', 'enable', 'toggle' } do
    local name = action:gsub('^%l', string.upper) .. 'FormatOnSave'
    cmd(name, function(o)
        local bufnr = tonumber(o.args) or vim.api.nvim_get_current_buf()
        local ok, err = pcall(
            formatter[action .. '_fmt_on_save'],
            o.bang and 'global' or bufnr
        )
        if ok then
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            vim.notify(
                ("`%s`'d format-on-save for `%s`. It is now %s."):format(
                    action,
                    o.bang and 'global' or bufname,
                    err
                )
            )
        else
            vim.notify(err)
        end
    end, {
        desc = ("`%s`'s format-on-save for buffer."):format(action),
        bang = true,
        nargs = '?',
    })
end
