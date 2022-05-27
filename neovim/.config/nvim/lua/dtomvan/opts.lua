local ops = vim.opt

ops.autoindent = true
ops.background = 'dark'
ops.backup = false
ops.clipboard = 'unnamedplus'
ops.cmdheight = 1
ops.compatible = false
ops.completeopt = 'menuone'
ops.completeopt = { 'menuone', 'noinsert', 'noselect' }
ops.copyindent = true
ops.cursorline = true
ops.expandtab = true
ops.expandtab = true
ops.hidden = true
ops.ignorecase = true
ops.lazyredraw = true
ops.listchars = 'trail:·,tab:>--,lead:-,nbsp:~'
ops.list = true
ops.mouse = 'a'
ops.number = true
ops.number = true
ops.relativenumber = true
ops.rnu = true
ops.scrolloff = 8
ops.shiftwidth = 4
ops.shiftwidth = 4
ops.shortmess = ops.shortmess + 'a'
ops.showtabline = 1
ops.signcolumn = 'yes'
ops.smartcase = true
ops.softtabstop = 4
ops.swapfile = true
ops.tabstop = 4
ops.tabstop = 4
ops.termguicolors = true
ops.textwidth = 120
ops.textwidth = 80
ops.timeoutlen = 500
ops.title = true
ops.undofile = true
ops.updatetime = 300
ops.wrap = true
ops.wrap = true
ops.writebackup = true
vim.g.mapleader = ' '

if vim.fn.has 'nvim-0.7' == 1 then
    ops.ls = 3
end
if vim.fn.has 'nvim-0.8' == 1 then
    ops.winbar = '%!luaeval("require\\"dtomvan.utils\\".winbar()")'
    -- ops.winbar = '%=%m %f'
end
