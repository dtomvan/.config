alias c=clear;

alias j=just;
alias jc='just --choose';
alias ~j='just --justfile ~/Justfile';
alias ~jc='just --justfile ~/Justfile --choose';
alias .j='just --justfile ~/Justfile --working-directory .'
alias .jc='just --justfile ~/Justfile --working-directory . --choose'

alias doc='rustup docs';

set PATH ~/.cargo/bin/ ~/tetris-os/i386-elf-7.5.0-Linux-x86_64/bin ~/.local/bin $PATH

abbr b clifm
abbr g git
abbr pf '~/venv/bin/nvr -c ":Clap filer"';
abbr tovim "~/venv/bin/nvr -c \"cd \"(pwd)";
abbr t tmux
abbr x 'xplr';
abbr zel zellij
alias dir=broot;
alias e=nvim;
alias get="keyvcli get";
alias kv=keyvcli;
alias pr="cd ~/projects && cd (command ls -d */ | sk)";

export EDITOR=nvim;

set -gx PULSE_LATENCY_MSEC 30
zoxide init fish --cmd d | source
fish_vi_key_bindings
~/.config/fish/gen-flatpak-aliases.sh 2> /dev/null | source
