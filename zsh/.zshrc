# Created by newuser for 5.8

alias luamake=/home/tomvd/.cache/nvim/nlua/sumneko_lua/lua-language-server/3rd/luamake/luamake
export PATH=~/.cargo/bin:$PATH
if [[ "$(tty)" == "/dev/tty1" ]] ; then
	[[ $XDG_VTNR -le 2 ]] && tbsm
fi
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tomvd/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
