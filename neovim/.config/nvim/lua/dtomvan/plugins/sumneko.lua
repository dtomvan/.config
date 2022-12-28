local function get_lua_runtime()
    local result = {}
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. '/lua/'
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end

    return result
end

return {
    'tjdevries/nlua.nvim',
    ft = 'lua',
    dependencies = 'L3MON4D3/LuaSnip',
    config = function()
        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, 'lua/?.lua')
        table.insert(runtime_path, 'lua/?/init.lua')

        local snip_env = require('luasnip').session.config.snip_env
        local lua_globals = {
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
        }

        for k, _ in pairs(snip_env) do
            table.insert(lua_globals, k)
        end

        local opts = require 'dtomvan.lsp.opts'
        require('lspconfig').sumneko_lua.setup {
            settings = {
                Lua = {
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = 'space',
                            indent_size = '4',
                        },
                    },
                    runtime = {
                        version = 'LuaJIT',
                        path = runtime_path,
                    },
                    completion = {
                        keywordSnippet = 'Disable',
                        showWord = 'Disable',
                    },
                    diagnostics = {
                        enable = true,
                        disable = {
                            'trailing-space',
                        },
                        globals = lua_globals,
                    },
                    workspace = {
                        library = get_lua_runtime(),
                        maxPreload = 10000,
                        preloadFileSize = 10000,
                    },
                },
            },
            filetypes = { 'lua' },
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
            root_dir = require('lspconfig.util').find_git_ancestor,
        }
    end,
}
