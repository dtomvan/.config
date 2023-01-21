local util = require 'dtomvan.utils'
local sessions = require 'mini.sessions'
sessions.setup {}

local function saction(a)
    return function()
        MiniSessions.select(a)
    end
end

vim.keymap.set('n', '<leader>sr', saction 'read')
vim.keymap.set('n', '<leader>sw', saction 'write')
vim.keymap.set('n', '<leader>sd', saction 'delete')
vim.keymap.set('n', '<leader>sn', function()
    local split = vim.split(vim.fn.getcwd(), '/')
    vim.ui.input({ prompt = 'Session name? ', default = split[#split] }, function(input)
        if input == nil then
            return
        end
        local existing = false
        for session in ipairs(MiniSessions.detected) do
            if session.name == input then
                existing = true
                util.yes_or_no('Do you want to overwrite the existing session', false, function(b)
                    if b then
                        MiniSessions.write(input, { force = true })
                    end
                end)
            end
        end
        if existing then
            return
        end
        MiniSessions.write(input, {})
    end)
end)

local starter = require 'mini.starter'
local logo_table = require 'dtomvan.ascii_art'.logo
local logo_width = #logo_table[1]

local started = false

-- Launches the Starter after Lazy.nvim loaded all plugins and we can show what
-- our startuptime was
local id = vim.api.nvim_create_augroup('LazyVimStats', { clear = true })
vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyVimStarted',
    group = id,
    callback = function()
        started = true
        starter.config.autoopen = true
        starter.on_vimenter()
    end,
})

local get_startuptime = function()
    if not started then
        return ''
    else
        local stats = require('lazy').stats()
        return ('\nLoaded %d packages in %dms'):format(stats.loaded, stats.startuptime)
    end
end
local bd_msg = 'Happy Birthday!'
local birthday = function()
    if os.date '%d%m' == '2012' then
        return {
            {
                action = function()
                    local bufnr = vim.api.nvim_create_buf(false, true)
                    vim.cmd.b(bufnr)
                    vim.api.nvim_buf_set_lines(0, 0, 0, false, require('dtomvan.ascii_art').birthday)
                end,
                name = bd_msg,
                section = '20th of december!',
            },
        }
    else
        return {}
    end
end

-- Makes the happy birthday message rainbow (by using some weird builtin highlight groups)
local birthday_hl = function(content)
    local coords = MiniStarter.content_coords(content, 'item')
    for _, c in ipairs(coords) do
        local unit = content[c.line][c.unit]
        local item = unit.item
        local hl = {
            'Error',
            'Float',
            'WarningMsg',
            'String',
            'Function',
            'Exception',
        }
        if item.name == bd_msg then
            table.remove(content[c.line], c.unit)
            for i = #item.name, 1, -1 do
                table.insert(content[c.line], c.unit, {
                    string = item.name:sub(i, i),
                    hl = hl[(i - 1) % #hl + 1],
                })
            end
            table.insert(content[c.line], c.unit, { string = '', type = 'item', item = item })
        end
    end
    return content
end

local logo_expla = logo_table[#logo_table]
local logo_expla_hl = function(content)
    local coords = MiniStarter.content_coords(content, 'header')
    for _, c in ipairs(coords) do
        if content[c.line][c.unit].string == logo_expla then
            content[c.line][c.unit].hl = 'Comment'
        end
    end
    return content
end

-- Removes the "Sessions" sections if there are none
local remove_empty_sessions = function(content)
    local coords = MiniStarter.content_coords(content, 'item')
    local found
    for _, c in ipairs(coords) do
        if content[c.line][c.unit].item.name == "There are no detected sessions in 'mini.sessions'" and not found then
            found = c.line
        end
    end
    if found then
        for i = 1, 3, 1 do
            table.remove(content, found - 1)
        end
    end
    return content
end

-- Shortens recent file paths to at most 80 characters, adds visual aid when
-- doing so and right-aligns the paths to the file afterwards.
local clean_recent_files = function(content)
    local coords = MiniStarter.content_coords(content, 'item')
    local longest = 0
    local cols = vim.o.columns

    for _, c in ipairs(coords) do
        local item = content[c.line][c.unit].item
        if item.section ~= 'Recent files' then
            goto continue
        end

        local name = item.name:gsub('(.*)/(.*)%)', '%1)')
        local path_start = name:find '%('
        local filename = name:sub(1, path_start - 2)
        local path = name:sub(path_start + 1, name:find '%)' - 1), 4
        local split = vim.split(filename, '.', { plain = true })
        local icon, hl = require('nvim-web-devicons').get_icon(filename, split[#split],
            { default = true })

        if #icon ~= 0 then
            icon = icon .. ' '
        end

        item._len = #name
        item._icon = icon
        item._hl = hl

        if #name > math.min(cols, 80) then
            path = vim.fn.pathshorten(path, 4)
            -- minus 2 for icons or bullets
            local max_width = math.min(cols / 2 - 2, 40)
            local flen = #filename
            local plen = #path

            local filename_ellipsis = flen - max_width - 3 > 2
            local path_ellipsis = plen - max_width - 3 > 2

            filename = filename:sub(1, math.min(flen, max_width))
            path = path:sub(plen - math.min(plen, max_width), plen)

            name = ('%s%s (%s%s)'):format(
                filename,
                filename_ellipsis and '...' or '',
                path_ellipsis and '...' or '',
                path
            )
            local new_line = { { string = filename, type = 'item', item = item } }
            if filename_ellipsis then
                table.insert(new_line, { string = '...', hl = 'Comment' })
            end
            table.insert(new_line, { string = ' (', hl = 'Comment' })
            if path_ellipsis then
                table.insert(new_line, { string = '...', hl = 'Comment' })
            end
            table.insert(new_line, { string = path, hl = 'Italic' })
            table.insert(new_line, { string = ')', hl = 'Comment' })
            content[c.line] = new_line
        else
            local new_line = {
                { string = filename, type = 'item', item = item },
                { string = ' (', hl = 'Comment' },
                { string = path },
                { string = ')', hl = 'Comment' },
            }
            content[c.line] = new_line
        end
        local len = #name
        if len > longest then
            longest = len
        end
        ::continue::
    end
    for _, c in ipairs(coords) do
        local unit = content[c.line][1]
        local item = unit.item
        if item.section ~= 'Recent files' then
            goto continue
        end
        local pad = string.rep(' ', math.min(math.max(logo_width - item._len - 2, longest - item._len), cols - item._len))

        content[c.line][1].string = unit.string .. pad
        ::continue::
    end
    return content
end

-- modified version of MiniStarter.gen_hook.adding_bullet to add a filetype icon
-- on recent files
local function adding_bullet(place_cursor)
    place_cursor = place_cursor == nil and true or place_cursor
    return function(content)
        local coords = MiniStarter.content_coords(content, 'item')
        -- Go backwards to avoid conflict when inserting units
        for i = #coords, 1, -1 do
            local l_num, u_num = coords[i].line, coords[i].unit
            local item = content[l_num][u_num].item
            local bullet = item._icon or '░ '
            local bullet_unit = {
                string = bullet,
                type = 'item_bullet',
                hl = item._hl or 'MiniStarterItemBullet',
                item = item,
                _place_cursor = place_cursor,
            }
            table.insert(content[l_num], u_num, bullet_unit)
        end

        return content
    end
end

local function nothing_if_too_small(content)
    if vim.o.columns < 30 then
        return { { { type = 'item', string = 'Window too small',
            item = { name = '', action = 'enew', section = '' } } } }
    end
    return content
end

starter.setup {
    autoopen = false,
    header = function()
        local hour = tonumber(os.date '%H')
        -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
        local part_id = math.floor((hour + 4) / 8) + 1
        local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]
        local username = vim.loop.os_get_passwd()['username'] or 'dtomvan'
        local text = ('Good %s, %s%s'):format(day_part, username, get_startuptime())
        local to_align = vim.split(text, '\n')
        local cols = vim.o.columns

        if cols > (logo_width + 10) then
            local logo = table.concat(logo_table, '\n')

            for i, line in ipairs(to_align) do
                to_align[i] = string.rep(' ', (logo_width - #line) / 2) .. line
            end
            local header = table.concat(to_align, '\n')
            return logo .. '\n\n' .. header
        else
            return text
        end
    end,
    footer = vim.fn.system('shuf -n1 ~/.config/nvim/inspirational_quotes.txt'):gsub('\\n', '\n'):gsub('\n$', ''),
    items = {
        birthday(),
        starter.sections.sessions(),
        starter.sections.recent_files(10),
    },
    content_hooks = {
        nothing_if_too_small,
        remove_empty_sessions,
        birthday_hl,
        logo_expla_hl,
        clean_recent_files,
        adding_bullet(false),
        starter.gen_hook.aligning('center', 'center'),
    },
}

vim.api.nvim_set_hl(0, 'MiniStarterFooter', { link = 'MiniStarterSection'})
