return {
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
