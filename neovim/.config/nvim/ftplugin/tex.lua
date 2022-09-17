local user_cmd = vim.api.nvim_buf_create_user_command

local M = {}

M.compilers = {
    ---@class tex.Compiler
    ---@field name string
    ---@field cmd string
    {
        name = 'PDFTeX',
        cmd = 'pdflatex {}',
    },
    {
        name = 'LaTeX',
        cmd = 'latex {}',
    },
    {
        name = 'XeLaTeX',
        cmd = 'xelatex {}',
    },
    {
        name = 'LuaLaTeX',
        cmd = 'lualatex {}',
    },
    {
        name = 'Tectonic',
        cmd = 'tectonic {}',
    },
}

M.viewers = {
    ---@type tex.Compiler
    {
        name = 'Zathura',
        cmd = 'zathura {}',
    },
    {
        name = 'Calibre',
        cmd = 'calibre {}',
    },
    {
        name = 'Foliate',
        cmd = 'foliate {}',
    },
    {
        name = 'GNOME Books',
        cmd = 'gnome-books {}',
    },
    {
        name = 'Elementary Bookworm',
        cmd = 'bookworm {}',
    },
    {
        name = 'Pandoc',
        cmd = 'pandoc -f latex -t pdf -o {out} {}',
    },
}

---@param infile fun(infile: string): string
---@param cmdprompt fun(name: string, cmpname: string): string
---@param compiler tex.Compiler
---@param job boolean
---@param done nil | fun(): any
local function run(infile, cmdprompt, compiler, job, done)
    if not compiler then
        return
    end
    local name = infile(vim.fn.expand '%:.:~')
    local cmd = string.gsub(compiler.cmd, '{}', name)
    cmd = string.gsub(cmd, '{out}', name:gsub('.tex$', '.pdf'))
    vim.ui.input({ prompt = cmdprompt(name, compiler.name), default = cmd }, function(c)
        if not c then
            return
        end
        local opts = {
            detach = 1,
            on_exit = function(_, code)
                pcall(done or function() end, code)
            end,
        }
        if job then
            vim.fn.jobstart(c, opts)
        else
            EX.vnew()
            local bufnr = vim.api.nvim_get_current_buf()
            opts.on_exit = function(_, code)
                if code == 0 then
                    EX.bdelete(bufnr)
                end
                pcall(done or function() end, code)
            end
            vim.fn.termopen(c, opts)
        end
    end)
end

---@param cmdname string
---@param collection table
---@param selprompt string
---@param cmdprompt fun(name: string, cmpname: string): string
---@param infile fun(infile: string): string
---@param desc string
---@param jobstart boolean
local function view_compile(cmdname, collection, selprompt, cmdprompt, infile, desc, jobstart)
    local function handler(opts, done)
        if not opts then
            opts = { args = '' }
        end
        if not opts.args then
            opts.args = ''
        end
        EX.update()
        ---@type tex.Compiler
        local compiler = { name = opts.args, cmd = tostring(opts.args) .. ' {}' }
        if #opts.args == 0 then
            vim.ui.select(collection, {
                prompt = selprompt,
                format_item = function(item)
                    return item.name
                end,
            }, function(choice)
                run(infile, cmdprompt, choice, jobstart, done)
            end)
        else
            run(infile, cmdprompt, compiler, jobstart, done)
        end
    end
    user_cmd(0, cmdname, handler, {
        bar = true,
        nargs = '*',
        desc = desc,
    })
    return handler
end

M.compile = view_compile('Compile', M.compilers, 'Select which LaTeX compiler to use: ', function(name, cmpname)
    return string.format('Compile %s with %s: ', name, cmpname)
end, function(infile)
    return infile
end, 'Compile current LaTeX document.', false)

M.view = view_compile('View', M.viewers, 'Select which PDF viewer to use: ', function(name, cmpname)
    return string.format('View %s using %s: ', name, cmpname)
end, function(infile)
    return infile:gsub('.tex$', '.pdf')
end, 'View produced PDF document.', true)

user_cmd(0, 'CView', function(_)
    M.compile({ name = 'Tectonic', cmd = 'tectonic {}' }, function(code)
        if code == 0 then
            M.view { name = 'Zathura', cmd = 'zathura {}' }
        end
    end)
end, { desc = ':Compile and :View' })

vim.keymap.set('n', '<leader>cb', '<cmd>Compile<cr>')
vim.keymap.set('n', '<leader>ct', '<cmd>View<cr>')
vim.keymap.set('n', '<leader>cr', '<cmd>CView<cr>')
