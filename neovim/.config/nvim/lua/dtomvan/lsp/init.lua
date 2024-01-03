if vim.g.started_by_firenvim then
    return
end

require 'neoconf'.setup {}
require 'neodev'.setup {}

local mason_lspconfig = require 'mason-lspconfig'
local opts = require 'dtomvan.lsp.opts'

mason_lspconfig.setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup(opts)
        if not package.loaded.ufo then
            require('ufo').setup()
        end
    end,
    lua_ls = CONF.lua_ls,
    ["rust_analyzer"] = function()
        require('rust-tools').setup(require 'dtomvan.lsp.rust')
    end,
    ltex = function()
        require 'lspconfig'.ltex.setup(vim.tbl_deep_extend('force', opts, { filetypes = { "tex" }, }))
    end,
    rome = function()
        require 'lspconfig'.rome.setup(vim.tbl_deep_extend('force', opts, {
            filetypes = {
                'javascript',
                'javascriptreact',
                'typescript',
                'typescript.tsx',
                'typescriptreact',
            },
        }))
    end
}
