local tbl = require 'dtomvan.utils.tables'
local formatter = require 'dtomvan.formatter'
local noremap = require('dtomvan.keymaps').noremap

local cmd = vim.api.nvim_create_user_command
local system = vim.fn.system

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
end

cmd('GoFt', thisft, { desc = 'Open current ftplugin', force = true })
vim.keymap.set(
    'n',
    '<space>gft',
    thisft,
    noremap 'Open ftplugin for current :set filetype'
)

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
    local start = vim.api.nvim_get_current_buf()
    vim.cmd 'vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis'

    local scratch = vim.api.nvim_get_current_buf()
    vim.cmd 'wincmd p | diffthis'
    for _, buf in ipairs { scratch, start } do
        vim.keymap.set('n', 'q', function()
            vim.api.nvim_buf_delete(scratch, { force = true })
            vim.keymap.del('n', 'q', { buffer = start })
        end, { buffer = buf })
    end
end, { desc = 'Diff current file with version before last save' })

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
    return tbl.get_filter_startswith(
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
        vim.notify(vim.inspect(tbl.map_get(cl, 'name')))
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
cmd('QBuffers', function()
    vim.fn.setqflist(vim.tbl_map(
        function(x) return { bufnr = x } end,
        vim.tbl_filter(
            function(x) return vim.fn.buflisted(x) == 1 end,
            vim.api.nvim_list_bufs()
        ))
    )
end, {
    desc = 'Put all buffers as entries in the quickfixlist',
    force = true,
    nargs = 0,
})

cmd('Dym', function(o)
    local word
    if o.bang then
        word = vim.fn.expand '<cWORD>'
    else
        word = vim.fn.expand '<cword>'
    end
    ---@cast word string
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(buf, true, {
        row = 0,
        col = 0,
        width = 60,
        height = 10,
        relative = 'cursor',
        anchor = 'SW',
        border = 'single',
    })
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf })
    vim.system({ 'dym', word }, {
        text = true,
        stdout = function(err, data)
            if err or not data then return end
            vim.schedule(function()
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, vim.split(data, '\n', { trimempty = true }))
            end)
        end
    })
end, {
    desc = 'Executes `dym` on current word under cursor, with bang WORD under cursor',
    force = true,
    nargs = 0,
    bang = true,
})

cmd('Sdo', function(o)
    local last_search = vim.fn.getreg "/"
    vim.cmd.vimgrep(last_search, "%")
    vim.cmd.cdo(o.args)
end, {
    desc = "Like `cdo` but for the search results.",
    force = true,
    nargs = '+',
})
