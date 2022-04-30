local function _1_()
    local term = require 'term'
    local k_hsplit = term.profile_tmux_hsplit()
    k_hsplit.key = 'ctrl-h'
    return term.setup { term.profile_tmux_vsplit(), k_hsplit }
end
use_plugin('igorepst/term.xplr', 'setup', _1_)
return use_plugin 'dtomvan/icons.xplr'
