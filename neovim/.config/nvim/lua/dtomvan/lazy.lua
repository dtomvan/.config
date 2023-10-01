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

local Process = require 'dtomvan.utils.proc'.Process
local is_rwds = vim.iter(Process:new(vim.fn.getpid() or 1):parents())
    :find(function(x)
        return vim.fs.basename(x:resolved_cmdline()[1]) == 'rwds-cli'
    end)

local spec = is_rwds
    and { import = 'dtomvan.plugins.colorscheme' }
    or { import = 'dtomvan.plugins' }

require('lazy').setup({
    spec = {
        spec
    },
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
