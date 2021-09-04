if [[ "$(tty)" == "/dev/tty1" ]] ; then
	startx &> /dev/null
fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.8

alias luamake=/home/tomvd/.cache/nvim/nlua/sumneko_lua/lua-language-server/3rd/luamake/luamake
export PATH=~/.cargo/bin:~/.local/bin:$PATH
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _list _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 25
zstyle ':completion:*' menu select=long
zstyle ':completion:*' prompt 'Complete: %e errors'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/tomvd/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Bootstrap p10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme || yay -S --noconfirm zsh-theme-powerlevel10k-git || paru -S --noconfirm zsh-theme-powerlevel10k-git

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.profile

source /home/tomvd/.config/broot/launcher/bash/br
