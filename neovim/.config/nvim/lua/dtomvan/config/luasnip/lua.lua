return {
    s(
        { trig = 'req', priority = 1000000 },
        fmt([[local {} = require '{}']], {
            c(2, {
                f(function(name)
                    local split = vim.split(name[1][1], '.', true)
                    return split[#split] or ''
                end, { 1 }),
                i(1),
            }),
            i(1),
        })
    ),
}
