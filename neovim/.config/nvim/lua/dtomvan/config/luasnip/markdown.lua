return {
    s(
        { trig = '%[%.%.%.%]%(([^%)]+)%)', regTrig = true, wordTrig = false },
        c(1, {
            d(nil, function(_, s)
                return sn(nil, {
                    t { '[' },
                    i(1, '...'),
                    t { '](' },
                    i(2, s.captures[1]),
                    t { ')' },
                })
            end, {}),
            d(nil, function(_, s)
                return sn(nil, { i(1, s.captures[1]) })
            end, {}),
        })
    ),
}
