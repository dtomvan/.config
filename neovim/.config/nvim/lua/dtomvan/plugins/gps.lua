local navic_to_cmp = {
    NavicIconsClass = 'CmpItemKindClass',
    NavicIconsConstant = 'CmpItemKindConstant',
    NavicIconsConstructor = 'CmpItemKindConstructor',
    NavicIconsEnum = 'CmpItemKindEnum',
    NavicIconsEnumMember = 'CmpItemKindEnumMember',
    NavicIconsField = 'CmpItemKindField',
    NavicIconsFile = 'CmpItemKindFile',
    NavicIconsFunction = 'CmpItemKindFunction',
    NavicIconsInterface = 'CmpItemKindInterface',
    NavicIconsKeyword = 'CmpItemKindKeyword',
    NavicIconsMethod = 'CmpItemKindMethod',
    NavicIconsModule = 'CmpItemKindModule',
    NavicIconsNamespace = 'CmpItemKindModule',
    NavicIconsObject = 'CmpItemKindModule',
    NavicIconsOperator = 'CmpItemKindOperator',
    NavicIconsProperty = 'CmpItemKindProperty',
    NavicIconsStruct = 'CmpItemKindStruct',
    NavicIconsString = 'CmpItemKindText',
    NavicIconsTypeParameter = 'CmpItemKindTypeParameter',
    NavicIconsValue = 'CmpItemKindValue',
    NavicIconsKey = 'CmpItemKindVariable',
}

local M = {
    'SmiteshP/nvim-navic',
    lazy = true,
    dependencies = 'neovim/nvim-lspconfig',
    opts = {
        icons = {
            File = ' ',
            Module = ' ',
            Namespace = ' ',
            Package = ' ',
            Class = ' ',
            Method = ' ',
            Property = ' ',
            Field = ' ',
            Constructor = ' ',
            Enum = ' ',
            Interface = ' ',
            Function = ' ',
            Variable = ' ',
            Constant = ' ',
            String = ' ',
            Number = ' ',
            Boolean = ' ',
            Array = ' ',
            Object = ' ',
            Key = ' ',
            Null = ' ',
            EnumMember = ' ',
            Struct = ' ',
            Event = ' ',
            Operator = ' ',
            TypeParameter = ' ',
        },
        separator = ' > ',
        highlight = true,
    },
}

M.config = function(_, opts)
    require('nvim-navic').setup(opts)

    for from, to in pairs(navic_to_cmp) do
        vim.api.nvim_set_hl(0, from, { default = true, link = to })
    end
end

return M
