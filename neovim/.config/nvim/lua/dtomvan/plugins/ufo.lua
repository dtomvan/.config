local function prev_peek()
    require('ufo').goPreviousClosedFold()
    require('ufo').peekFoldedLinesUnderCursor()
end

local function next_peek()
    require('ufo').goNextClosedFold()
    require('ufo').peekFoldedLinesUnderCursor()
end

return {
    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            require 'ufo'.setup()
        end,
        keys = {
            { 'zR', function() require('ufo').openAllFolds() end },
            { 'zM', function() require('ufo').closeAllFolds() end },
            { 'zk', prev_peek },
            { 'zj', next_peek },
        },
        init = function()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
    },
}
