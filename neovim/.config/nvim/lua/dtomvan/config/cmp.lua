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
local ls = require 'luasnip'

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
            elseif ls.expand_or_jumpable() then
                ls.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif ls.jumpable(-1) then
                ls.jump(-1)
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

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = ({
                cmdline = '[cmd]',
                path = '[path]',
            })[entry.source.name]
            return vim_item
        end,
    },
})

cmp.setup.filetype('query', {
    sources = {
        { name = 'omni' },
    },
})

-- nvim-autopairs setup
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local handlers = require 'nvim-autopairs.completion.handlers'

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done {
        filetypes = {
            ['*'] = {
                ['('] = {
                    kind = {
                        cmp.lsp.CompletionItemKind.Function,
                        cmp.lsp.CompletionItemKind.Method,
                    },
                    handler = handlers['*'],
                },
            },
        },
    }
)

return sources
