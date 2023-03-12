local utils = require 'dtomvan.lsutils'

local no_word = function(trig)
    return { wordTrig = false, trig = trig }
end

local rec_ls = utils.make_rec '\t\\item '

local frac_nodes = fmta('\\frac{<>}{<>}', { i(1), i(2) })

local opt_eq = function(name)
    return { name = name, eq = true }
end

local opt = function(name)
    return { name = name, eq = false }
end

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

        local comma = old_state.comma and ',' or ''
        local eq = option.eq and '=' or ''
        local new_nodes = { t(comma .. option.name .. eq), i(1) }
        if #options > 1 then
            table.insert(
                new_nodes,
                d(2, opt_choice, {}, { user_args = new_options })
            )
        end
        local new_snip = sn(nil, new_nodes)
        new_snip.old_state = vim.deepcopy(old_state)
        new_snip.old_state.comma = true

        table.insert(option_nodes, new_snip)
    end
    return sn(nil, { c(1, option_nodes) })
end

local package_opts = function(pkgname, opts, abbr, fix)
    fix = fix or {}
    return s(
        abbr or pkgname,
        fmta((fix.pre or '') .. '\\usepackage<>{<>}' .. (fix.post or ''), {
            c(1, {
                t '',
                sn(nil, {
                    t '[',
                    d(1, opt_choice, {}, { user_args = opts }),
                    t ']',
                }),
            }),
            t(pkgname),
        })
    )
end

local parse_ok, font_query = pcall(
    vim.treesitter.parse_query,
    'latex',
    [[
(package_include
  options:
  (brack_group_key_value
    pair: (key_value_pair key: (text) @_key (#eq? @_key "T1")))
  paths: (curly_group_path_list
           path: (path) @_packagename
           (#eq? @_packagename "fontenc"))) @capture
]]
)

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
        fmta('\\begin{<>}<>\n<>\n\\end{<>}', {
            i(1),
            c(2, { t '', sn(nil, { t '[', i(1), t ']' }) }),
            i(3),
            utils.ri(1),
        })
    ),
    s({ trig = 'mk', wordTrig = true }, {
        t '$',
        i(1),
        t '$',
        f(function(args)
            if
                string.find(args[1][1], '[,.?-]')
                or string.find(args[1][1], ' ')
            then
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

<>
<>

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
                c(5, {
                    t '\\input{../preamble.tex}',
                    t '',
                }),
                i(6),
                i(7),
            }
        )
    ),
    s('frac', vim.deepcopy(frac_nodes)),
    s('sympy', fmt('sympy {} sympy', { i(1) })),
    s({ trig = 'sympy(.*)sympy', regTrig = true, priority = 10000 }, {
        d(1, function(_, snip)
            local nodes = vim.split(
                vim.fn.system { 'sympy-eval.py', snip.captures[1] },
                '\n'
            )
            return sn(nil, { t(nodes) })
        end, {}),
    }),
    s('lim', fmta('\\lim_{<> \\to <>}', { i(1, 'n'), i(2, '\\infty') })),
    s('tex', t '\\TeX{}'),
    s('latex', t '\\LaTeX{}'),
    s('use', fmta('\\usepackage{<>}', { i(1) })),
    s('lstlst', t '\\lstlistoflistings'),
    -- TODO: DRY
    s(
        'lst',
        fmta('\\begin{lstlisting}<>\n<>\n\\end{lstlisting}', {
            c(1, {
                t '',
                sn(nil, {
                    t '[',
                    d(1, opt_choice, {}, {
                        user_args = {
                            opt_eq 'language',
                            opt_eq 'caption',
                        },
                    }),
                    t ']',
                }),
            }),
            i(2),
        })
    ),
    -- Imports for hyperref
    package_opts(
        'hyperref',
        { opt_eq 'colorlinks', opt 'hidelinks', opt 'linktocpage' },
        'hyper'
    ),
    package_opts(
        'carlito',
        { opt 'sfdefault', opt 'lf' },
        'calibri',
        { post = '\n\\renewcommand*\\oldstylenums[1]{\\carlitoOsF #1}' }
    ),
    -- Use treesitter to determine wether the fontenc stuff needs to be
    -- reincluded
    s(
        'font',
        fmta('<>\\usepackage{<>}', {
            f(function()
                local def = { '\\usepackage[T1]{fontenc}', '' }
                if not parse_ok then
                    return def
                end
                local bufnr = vim.api.nvim_get_current_buf()
                local condition = false
                local parser = vim.treesitter.get_parser(bufnr, 'latex')
                if not parser then
                    return def
                end
                local tree = parser:parse()
                if not tree then
                    return def
                end
                for id in font_query:iter_captures(tree[1]:root(), bufnr) do
                    if font_query.captures[id] == 'capture' then
                        condition = true
                        break
                    end
                end
                if condition then
                    return ''
                else
                    return def
                end
            end),
            c(1, {
                i(nil, 'mathptmx'),
                i(nil, 'lmodern'),
                i(nil, 'palatino'),
                i(nil, 'charter'),
                i(nil, 'helvet'),
                i(nil, 'courier'),
            }),
        })
    ),
    s(
        'chft',
        fmta('{\\fontfamily{<>}\\selectfont\n<>\n}', {
            c(1, {
                i(nil, 'ptm'),
                i(nil, 'lmr'),
                i(nil, 'ppl'),
                i(nil, 'bch'),
                i(nil, 'phv'),
                i(nil, 'pcr'),
            }),
            i(2),
        })
    ),
    s('code', fmta('\\begin{verbatim}\n<>\n\\end{verbatim}', i(1))),
    s(
        'date',
        fmta(
            '\\date{<>}',
            c(1, {
                f(function()
                    return os.date '%F'
                end),
                i(nil),
            })
        )
    ),
    s(
        'lang',
        fmta(
            '\\usepackage[<>]{babel}',
            c(1, { i(nil, 'dutch'), i(nil, 'english') })
        )
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
            return sn(
                nil,
                { t(snip.captures[1] .. '_{' .. snip.captures[2]), i(1), t '}' }
            )
        end, {}),
    }),
    s(no_word 'sq', t '^2'),
    s(no_word 'cb', t '^3'),
    s(no_word 'compl', t '^{c}'),
    s(no_word 'td', fmta('^{<>}', { i(1) })),
    s('//', frac_nodes),
}

-- TODO: See L3MON4D3/LuaSnip#637
for i, _ in ipairs(autotrig) do
    local normal_snip = vim.deepcopy(autotrig[i])
    autotrig[i].condition = function()
        return vim.fn['vimtex#syntax#in_mathzone']() == 1
    end
    normal_snip.condition = function()
        return vim.fn['vimtex#syntax#in_mathzone']() == 0
    end
    table.insert(normal, normal_snip)
end

return normal, autotrig
