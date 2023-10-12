local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)

local spec = vim.g.is_rwds
    and {
        { import = 'dtomvan.plugins.colorscheme' },
        { import = 'dtomvan.plugins.noice' },
    }
    or { { import = 'dtomvan.plugins' } }

require('lazy').setup({
    spec = spec,
    dev = {
        fallback = true,
    },
    install = {
        colorscheme = {
            'catppuccin-mocha',
            'habamax',
        },
    },
    rtp = {
        disabled_plugins = {
            'gzip',
            'matchit',
            'matchparen',
            'netrwPlugin',
            'tarPlugin',
            'tohtml',
            'tutor',
            'zipPlugin',
        },
    },
    change_detection = {
        notify = false,
    },
})
