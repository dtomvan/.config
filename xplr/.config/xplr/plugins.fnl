(use_plugin :igorepst/term.xplr
 :setup (fn []
     (local term (require :term))
     (local k-hsplit (term.profile_tmux_hsplit))
     (set k-hsplit.key :ctrl-h)
     (term.setup {1 (term.profile_tmux_vsplit) 2 k-hsplit})))

(use_plugin :dtomvan/icons.xplr)
