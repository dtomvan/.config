local hydra = require 'dtomvan.config.hydra'
local o = hydra.o

local hint = [[
^ ^ Search:
^ ^ _/<space>_: all _/i_: issues _/p_: PRs ^ ^
^
^ ^ Issues:       PRs:          Misc:
^ ^ _ib_: Browser   _pb_: Browser   _aa_: +assignee
^ ^ _ic_: Create    _pc_: Create    _ar_: -assignee
^ ^ _ca_: +comment  _p~_: Changes   _tr_: Resolve
^ ^ _cr_: -comment  _p@_: Checkout  _tu_: Unresolve
^ ^               _p?_: Checks    _la_: +label
^ ^ _i-_: Close     _p-_: Close     _lr_: -label
^ ^               _pd_: Diff      _lc_: ++label
^ ^ _ie_: Edit      _pe_: Edit      _rr_: +reviewer
^ ^               _pL_: Commits
^ ^ _il_: List      _pl_: List
^ ^               _p<_: Merge
^ ^ _i;_: Reopen    _p;_: Reopen
^ ^               _pR_: Ready
^ ^ _ir_: Reload    _pr_: Reload
^ ^ _iu_: Url       _pu_: Url
^
^ ^ Reactions:    Repos:    Reviews:
^ ^ _+1_: :+1:      _rl_: List    _r-_: Close
^ ^ _-1_: :-1:      _rf_: Fork    _rc_: Comment
^ ^ _1_: :eyes:     _rb_: Browser _rC_: Commit
^ ^ _2_: :laugh:    _ru_: Url     _r._: Discard
^ ^ _3_: :confused: _rv_: View    _rR_: Resume
^ ^ _4_: :rocket:               _rs_: Start
^ ^ _5_: :heart:                _r=_: Submit
^ ^ _6_: :tada:
^
^ ^ _<enter>_: Neogit    _<space>_: Octo...     _<esc>_ _q_ ^ ^
]]

return {
    name = 'Octo',
    hint = hint,
    config = {
        hint = {
            border = 'rounded',
            position = 'middle',
        },
        invoke_on_body = true,
    },
    mode = { 'n' },
    body = '<leader>O',
    heads = {
        o('/i', 'Octo issue search'),
        o('ib', 'Octo issue browser'),
        o('ic', 'Octo issue create'),
        o('i-', 'Octo issue close'),
        o('ie', 'Octo issue edit'),
        o('il', 'Octo issue list'),
        o('i;', 'Octo issue reopen'),
        o('ir', 'Octo issue reload'),
        o('iu', 'Octo issue url'),

        o('/p', 'Octo pr search'),
        o('pb', 'Octo pr browser'),
        o('pc', 'Octo pr create'),
        o('p~', 'Octo pr changes'),
        o('p@', 'Octo pr checkout'),
        o('p?', 'Octo pr checks'),
        o('p-', 'Octo pr close'),
        o('pd', 'Octo pr diff'),
        o('pe', 'Octo pr edit'),
        o('pL', 'Octo pr commits'),
        o('pl', 'Octo pr list'),
        o('p<', 'Octo pr merge'),
        o('p;', 'Octo pr reopen'),
        o('pR', 'Octo pr ready'),
        o('pr', 'Octo pr reload'),
        o('pu', 'Octo pr url'),

        o('rl', 'Octo repo list'),
        o('rf', 'Octo repo fork'),
        o('rb', 'Octo repo browser'),
        o('ru', 'Octo repo url'),
        o('rv', 'Octo repo view'),

        o('ca', 'Octo comment add'),
        o('cr', 'Octo comment delete'),

        o('tr', 'Octo thread resolve'),
        o('tu', 'Octo comment unresolve'),

        o('la', 'Octo label add'),
        o('lr', 'Octo label remove'),
        o('lc', 'Octo label create'),

        o('aa', 'Octo assignee add'),
        o('ar', 'Octo assignee delete'),

        o('rr', 'Octo reviewer add'),
        o('r-', 'Octo review close'),
        o('rc', 'Octo review comments'),
        o('rC', 'Octo review commit'),
        o('r.', 'Octo review discard'),
        o('rR', 'Octo review resume'),
        o('rs', 'Octo review start'),
        o('r=', 'Octo review submit'),

        o('+1', 'Octo reaction thumbs_up'),
        o('-1', 'Octo reaction thumbs_down'),
        o('1', 'Octo reaction eyes'),
        o('2', 'Octo reaction laugh'),
        o('3', 'Octo reaction confused'),
        o('4', 'Octo reaction rocket'),
        o('5', 'Octo reaction heart'),
        o('6', 'Octo reaction tada'),

        o('/<space>', 'Octo search'),
        o('<space>', 'Octo'),
        { '<enter>', hydra.key_cmd 'Neogit', { exit = true, desc = 'Neogit' } },
        { '<esc>', nil, { exit = true, nowait = true, desc = 'exit' } },
        { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
    },
}
