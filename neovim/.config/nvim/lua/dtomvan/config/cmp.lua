if vim.g._no_cmp then
    return
end

local cmp = require 'cmp'

local sources = {
    { name = 'neorg' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'git' },
    { name = 'luasnip' },
    { name = 'zsh' },
    { name = 'path' },
}

cmp.setup {
    -- Don't go crazy on me, now
    -- Limits the amount of times we refresh, as well as how much lag I want
    -- Also just outputs 20 results, because who needs more anyways
    performance = {
        debounce = 200,
        throttle = 100,
        confirm_resolve_timeout = 80,
        fetching_timeout = 300,
        async_budget = 1,
        max_view_entries = 20,
    },
    preselect = cmp.PreselectMode.None,
    enabled = function()
        local context = require 'cmp.config.context'
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end
    end,
    window = {
        completion = {
            col_offset = -3,
            side_padding = 0,
        },
    },
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<c-y>'] = cmp.mapping.confirm { select = true },
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-n>'] = cmp.mapping.select_next_item(),
        ['<c-p>'] = cmp.mapping.select_prev_item(),
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
}

cmp.setup.filetype('query', {
    sources = {
        { name = 'omni' },
    },
})

cmp.setup.filetype("DressingInput", {
    sources = cmp.config.sources { { name = "omni" } },
})

return sources
