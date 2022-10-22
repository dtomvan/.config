local utils = require 'dtomvan.lsutils'

local no_word = function(trig)
    return { wordTrig = false, trig = trig }
end

local rec_ls = utils.make_rec '\t\\item '
local pak_ls = utils.make_rec('\\usepackage{', '}')

local frac_nodes = fmta('\\frac{<>}{<>}', { i(1), i(2) })

local opt_choice
opt_choice = function(_, snip, old_state, ...)
    old_state = snip.old_state or old_state or {
        comma = false,
    }
    local options = { ... }
    if #options == 0 then
        return sn(nil, { i(1) })
    end
    local option_nodes = { t '' }
    for opt_i, option in ipairs(options) do
        local new_options = vim.deepcopy(options)
        table.remove(new_options, opt_i)

        local comma
        if old_state.comma then
            comma = ','
        else
            comma = ''
        end
        local new_nodes = { t(comma .. option .. '='), i(1) }
        if #options > 1 then
            table.insert(new_nodes, d(2, opt_choice, {}, { user_args = new_options }))
        end
        local new_snip = sn(nil, new_nodes)
        new_snip.old_state = vim.deepcopy(old_state)
        new_snip.old_state.comma = true

        table.insert(option_nodes, new_snip)
    end
    return sn(nil, { c(1, option_nodes) })
end

local normal = {
    -- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many
    -- \item as necessary by utilizing a choiceNode.
    s('ls', {
        t { '\\begin{itemize}', '\t\\item ' },
        i(1),
        d(2, rec_ls, {}),
        t { '', '\\end{itemize}' },
    }),
    s(
        'beg',
        fmta(
            '\\begin{<>}<>\n<>\n\\end{<>}',
            { i(1), c(2, { t '', sn(nil, { t '[', i(1), t ']' }) }), i(3), utils.ri(1) }
        )
    ),
    s({ trig = 'mk', wordTrig = true }, {
        t '$',
        i(1),
        t '$',
        f(function(args)
            if string.find(args[1][1], '[,.?-]') or string.find(args[1][1], ' ') then
                return ''
            else
                return ' '
            end
        end, { 2 }),
        i(2),
    }),
    s('dm', fmt('\\[\n{}\n.\\]', { i(1) })),
    s(
        'document',
        fmta(
            [[<>

\title{<>}
\author{<>}
\date{<>}

\usepackage{amsmath}
\usepackage{graphicx}
\usepackage{enumitem}
\usepackage{listings}<>

\begin{document}

\maketitle

<>

\end{document}
]],
            {
                i(1, '\\documentclass[11pt,a4paper]{article}'),
                i(2, 'Insert title here'),
                c(3, { t 'Tom van Dijk', i(nil) }),
                i(4),
                d(5, pak_ls, {}),
                i(6),
            }
        )
    ),
    s('frac', vim.deepcopy(frac_nodes)),
    s('sympy', fmt('sympy {} sympy', { i(1) })),
    s({ trig = 'sympy(.*)sympy', regTrig = true, priority = 10000 }, {
        d(1, function(_, snip)
            local nodes = vim.split(vim.fn.system { 'sympy-eval.py', snip.captures[1] }, '\n')
            return sn(nil, { t(nodes) })
        end, {}),
    }),
    s('lim', fmta('\\lim_{<> \\to <>}', { i(1, 'n'), i(2, '\\infty') })),
    s('tex', t '\\TeX{}'),
    s('latex', t '\\LaTeX{}'),
    s('use', fmta('\\usepackage{<>}', { i(1) })),
    s('lstlst', t '\\lstlistoflistings'),
    s(
        'lst',
        fmta('\\begin{lstlisting}[<>]\n<>\n\\end{lstlisting}', {
            d(1, opt_choice, {}, { user_args = { 'language', 'caption' } }),
            i(2),
        })
    ),
}

local autotrig = {
    s(
        { trig = '([A-Za-z])(%d)', regTrig = true },
        f(function(_, snip)
            return snip.captures[1] .. '_' .. snip.captures[2]
        end, {})
    ),
    s({ trig = '([A-Za-z])_(%d%d)', regTrig = true }, {
        d(1, function(_, snip)
            return sn(nil, { t(snip.captures[1] .. '_{' .. snip.captures[2]), i(1), t '}' })
        end, {}),
    }),
    s(no_word 'sq', t '^2'),
    s(no_word 'cb', t '^3'),
    s(no_word 'compl', t '^{c}'),
    s(no_word 'td', fmta('^{<>}', { i(1) })),
    s('//', frac_nodes),
}

return normal, autotrig
