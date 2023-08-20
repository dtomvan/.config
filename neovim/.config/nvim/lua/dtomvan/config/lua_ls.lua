local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local opts = require 'dtomvan.lsp.opts'
require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = 'space',
                    indent_size = '4',
                },
            },
            completion = {
                keywordSnippet = 'Disable',
                showWord = 'Disable',
                workspaceWord = true,
                callSnippet = 'Both',
            },
            diagnostics = {
                enable = true,
                disable = {
                    'trailing-space',
                },
                globals = {
                    'vim',
                    'describe',
                    'it',
                    'before_each',
                    'after_each',
                    'teardown',
                    'pending',
                    'clear',
                    'Color',
                    'c',
                    'Group',
                    'g',
                    's',
                    'use',
                    'xplr',
                    'package',
                },
                groupFileStatus = {
                    ['ambiguity'] = 'Opened',
                    ['await'] = 'Opened',
                    ['codestyle'] = 'None',
                    ['duplicate'] = 'Opened',
                    ['global'] = 'Opened',
                    ['luadoc'] = 'Opened',
                    ['redefined'] = 'Opened',
                    ['type-check'] = 'Opened',
                    ['unbalanced'] = 'Opened',
                    ['unused'] = 'Opened',
                },
                unusedLocalExclude = { '_*' },
            },
        },
    },
    filetypes = { 'lua' },
    on_attach = function(cl, buf)
        opts.on_attach(cl, buf)
        for k, _ in pairs(require('luasnip').session.config.snip_env) do
            table.insert(cl.config.settings.Lua.diagnostics.globals, k)
        end
    end,
    capabilities = opts.capabilities,
}
