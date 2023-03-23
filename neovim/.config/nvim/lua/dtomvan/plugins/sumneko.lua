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

local function config()
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
                        globals = lua_globals,
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
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
            -- root_dir = require('lspconfig.util').find_git_ancestor,
        }
end

return {
    'tjdevries/nlua.nvim',
    ft = 'lua',
    dependencies = 'L3MON4D3/LuaSnip',
    config = config,
}
