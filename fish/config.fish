alias c=clear;

alias j=just;
alias jc='just --choose';
alias ~j='just --justfile ~/Justfile';
alias ~jc='just --justfile ~/Justfile --choose';
alias .j='just --justfile ~/Justfile --working-directory .'
alias .jc='just --justfile ~/Justfile --working-directory . --choose'

alias doc='rustup docs';

set PATH ~/.cargo/bin/ ~/tetris-os/i386-elf-7.5.0-Linux-x86_64/bin ~/.local/ $PATH

alias kv=keyvcli;
alias get="keyvcli get";
alias e=nvim;
alias dir=broot;
alias pr="cd ~/projects && cd (command ls -d */ | sk)";
abbr tovim "~/venv/bin/nvr -c \"cd \"(pwd)";
abbr pf '~/venv/bin/nvr -c ":Clap filer"';
abbr g git-client
abbr t tmux

export EDITOR=nvim;
bind \cr 'cargo r'

set -gx PULSE_LATENCY_MSEC 30
