local opt = vim.opt
local g = vim.g

opt.autoindent = true
opt.background = 'dark'
opt.backup = false
opt.clipboard = 'unnamedplus'
opt.cmdheight = 1
opt.compatible = false
opt.completeopt = 'menuone'
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
opt.conceallevel = 2
opt.copyindent = true
opt.cursorline = true
opt.expandtab = true
opt.expandtab = true
opt.hidden = true
opt.ignorecase = true
opt.lazyredraw = true
opt.listchars = 'trail:·,tab:>--,lead:-,nbsp:~'
opt.list = true
opt.mouse = 'a'
opt.number = true
opt.number = true
opt.relativenumber = true
opt.rnu = true
opt.scrolloff = 8
opt.shiftwidth = 4
opt.shiftwidth = 4
opt.shortmess = opt.shortmess + 'a'
opt.showtabline = 1
opt.signcolumn = 'yes'
opt.smartcase = true
opt.softtabstop = 4
opt.spelllang = 'en_us,nl'
opt.swapfile = true
opt.tabstop = 4
opt.tabstop = 4
opt.termguicolors = true
opt.textwidth = 120
opt.textwidth = 80
opt.timeoutlen = 500
opt.title = true
opt.undofile = true
opt.updatetime = 300
opt.wrap = true
opt.wrap = true
opt.writebackup = true
g.mapleader = ' '

-- `gf` mapping
_G.include_expr = function(fname)
    local f = ''
    if type(fname) == 'string' then
        f = fname
    else
        f = vim.v.fname
    end
    return string.gsub(f, '%.', '/')
end

if vim.fn.has 'nvim-0.7' == 1 then
    opt.ls = 3
end

if g.neovide ~= nil then
    g.neovide_transparency = 0.8
    -- Monitor's refresh rate + 30
    g.neovide_refresh_rate = 115
    g.neovide_floating_blur_amount_x = 2.0
    g.neovide_floating_blur_amount_y = 2.0
    g.neovide_cursor_antialiasing = true
    g.neovide_cursor_vfx_mode = 'railgun'
    g.neovide_scroll_animation_length = 0.3
end
