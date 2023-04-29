local o = vim.o
local g = vim.g

o.autoindent = true
o.background = 'dark'
o.backup = false
o.clipboard = 'unnamedplus'
o.cmdheight = 1
o.compatible = false
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
o.conceallevel = 2
o.copyindent = true
o.cursorline = true
o.expandtab = true
o.foldcolumn = 'auto'
o.grepprg = 'rg --vimgrep'
o.grepformat = '%f:%l:%c:%m'
o.hidden = true
o.ignorecase = true
o.langmap =
'ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz'
o.listchars = 'trail:·,nbsp:~,tab:>-,multispace:---+'
o.list = true
o.mouse = 'a'
o.nu = true
o.rnu = true
o.scrolloff = 8
vim.opt.shada:append 'r*://'
vim.opt.shada:append 'r/run/user/*'
vim.opt.shada:append 'rmain.shada'
o.shiftwidth = 4
o.showtabline = 1
o.signcolumn = 'yes'
o.smartcase = true
o.softtabstop = 4
-- o.spelllang = 'en_us,nl'
o.statusline = ' '
o.swapfile = true
o.tabstop = 4
o.termguicolors = true
o.textwidth = 80
o.title = true
o.undofile = true
o.updatetime = 300
o.wrap = true
o.writebackup = true
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
    o.ls = 3
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
