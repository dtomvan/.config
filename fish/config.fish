alias c=clear;

alias j=just;
alias jc='just --choose';
alias ~j='just --justfile ~/Justfile';
alias ~jc='just --justfile ~/Justfile --choose';
alias .j='just --justfile ~/Justfile --working-directory .'
alias .jc='just --justfile ~/Justfile --working-directory . --choose'

alias doc='rustup docs';

set PATH ~/.cargo/bin/ ~/.local/ $PATH

alias kv=keyvcli;
alias get="keyvcli get";
alias e=nvim;
alias dir=broot;
alias pr="cd ~/projects && cd (command ls -d */ | fzf)";
abbr g git-client

export EDITOR=nvim;
zoxide init fish --cmd d | source
bind \cr 'cargo r'
