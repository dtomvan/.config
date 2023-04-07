M = {
    'chrisgrieser/nvim-spider',
    opts = {
        skipInsignificantPunctuation = true,
    },
    keys = {},
}

for _, i in ipairs { 'w', 'e', 'b', 'ge' } do
    table.insert(M.keys, {
        i,
        function()
            require('spider').motion(i)
        end,
        mode = { 'n', 'x' },
        desc = 'Spider-' .. i,
    })
end

return M
