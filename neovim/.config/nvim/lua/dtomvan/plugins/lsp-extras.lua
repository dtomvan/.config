return {
    {
        'tjdevries/nlua.nvim',
        lazy = true,
        dependencies = 'L3MON4D3/LuaSnip',
    },
    {
        'SmiteshP/nvim-navbuddy',
        event = 'LspAttach',
        dependencies = {
            'neovim/nvim-lspconfig',
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
        },
    },
    {
        "Fildo7525/pretty_hover",
        -- bugs out
        enabled = false,
        event = "LspAttach",
        opts = {},
        config = function(_, opts)
            require 'pretty_hover'.setup(opts)
            vim.lsp.buf.hover = (function(overridden)
                return function(...)
                    local ok, ret = pcall(require 'pretty_hover'.hover, ...)
                    return ok and ret or overridden(...)
                end
            end)(vim.lsp.buf.hover)
        end
    },
}
