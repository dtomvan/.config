if vim.g._no_cmp then
    return
end
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match '%s'
        == nil
end
local cmp = require 'cmp'

local sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'git' },
    { name = 'luasnip' },
    { name = 'zsh' },
    { name = 'path' },
}

cmp.setup {
    window = {
        completion = {
            col_offset = -3,
            side_padding = 0,
        },
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<c-y>'] = cmp.mapping.confirm { select = true },
        ['<c-space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require('luasnip').expand_or_jumpable() then
                require('luasnip').expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require('luasnip').jumpable(-1) then
                require('luasnip').jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = cmp.config.sources(sources, { name = 'buffer' }),

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            local kind = require('lspkind').cmp_format {
                mode = 'symbol_text',
                maxwidth = 50,
                menu = {
                    buffer = '[buf]',
                    nvim_lsp = '[lsp]',
                    nvim_lua = '[api]',
                    path = '[path]',
                    luasnip = '[snip]',
                },
            } (entry, vim_item)
            local strings = vim.split(kind.kind, '%s', { trimempty = true })
            kind.kind = ' ' .. (strings[1] or '') .. ' '

            return kind
        end,
    },

    experimental = {
        ghost_text = true,
    },
}

cmp.setup.filetype('query', {
    sources = {
        { name = 'omni' },
    },
})

-- nvim-autopairs setup
local handler_confirm_done
cmp.event:on('confirm_done', function(...)
    if not handler_confirm_done then
        handler_confirm_done =
            require('nvim-autopairs.completion.cmp').on_confirm_done {
                filetypes = {
                    ['*'] = {
                        ['('] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method,
                            },
                            handler = require(
                                'nvim-autopairs.completion.handlers'
                            )['*'],
                        },
                    },
                },
            }
    end
    handler_confirm_done(...)
end)

return sources
