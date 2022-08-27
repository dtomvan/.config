[ -z "$ZPROF" ] || zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export BROWSER=waterfox-current
export EDITOR=nvim
export PATH=~/.local/bin/neovim/:~/.nix-profile/bin/:~/.cargo/bin:~/.local/bin:$PATH:$DENO_INSTALL/bin:~/.local/share/gem/ruby/3.0.0/bin:~/go/bin:~/.yarn/bin
export DENO_INSTALL="$HOME/.deno"
export RUSTC_WRAPPER=sccache
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

zle-keymap-select zle-line-init () {
  case $KEYMAP in
    vicmd) print -n '\e[0 q';;
    viins|main) print -n '\e[4 q';;
  esac
}

tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && pushd -q -- "$result"
}

# Pad = dutch for path
dmv() {
  name="$(command ls -t ~/Downloads | head -n 1)"
  pad="$HOME/Downloads/$name"
  mv "$pad" .
}
dcp() {
    name="$(command ls -t ~/Downloads | head -n 1)"
    pad="$HOME/Downloads/$name"
    cp -a "$pad" .
}

m() {
  python3 -c "from math import *; print($*)"
}

aoc() {
  tmux-sess ~/projects/aoc/$(date +%Y)
}

zle -N zle-keymap-select
zle -N zle-line-init

export HISTFILE=~/.histfile
export HISTSIZE=500000
export SAVEHIST=500000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null || true

setopt autocd extendedglob notify globdots noflowcontrol
unsetopt beep
bindkey -v
source ~/.profile

zstyle ':completion:*' completer _expand _complete _ignored _match _approximate _prefix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 10 numeric
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/tomvd/.zshrc'
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
autoload -Uz compinit
compinit

rationalise-dot() {
if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
else
    LBUFFER+=.
fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# FROM ARCH WIKI
# MAKES HOME,END,INSERT WORK
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

function my-expand-alias() { zle _expand_alias }
zle -N my-expand-alias
bindkey '^ ' my-expand-alias

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Stuff from DT's fish shell vid https://www.youtube.com/watch?v=8GN9D-OnG-A
alias cd='pushd -q'

DIR_STACK=()
prevd () {
  length=${#DIR_STACK[@]}
  next=$(($length + 1))

  if [[ `dirs -lp | wc -l` -ne 1 ]]; then
    DIR_STACK[$next]=`dirs -lp | head -n1`
    popd -q
  else
    echo "\nNo previous directory"
  fi
}
nextd () {
  length=${#DIR_STACK[@]}

  if [[ $length -ne 0 ]]; then
    pushd -q $DIR_STACK[$length]
    DIR_STACK[$length]=()
  else
    echo "\nNo next directory"
  fi
}
showhist() {
  echo
  length=${#DIR_STACK[@]}

  if [[ $length -ne 0 ]]; then
    echo 'Stack:'
  fi
  for i ("$DIR_STACK[@]"); do
    echo "$i" | sed "s/^${HOME//\//\\/}/~/"
  done
  echo 'You are here:'
  dirs -p
}
upd () {
  pushd -q ..
  showhist
}

wrapd () {
  $@
  zle push-line
  zle accept-line
}

wrap-prevd () { wrapd prevd }
wrap-nextd () { wrapd nextd }
wrap-upd () { wrapd upd }
wrap-downd () { wrapd showhist }

zle -N wrapd
zle -N wrap-prevd
zle -N wrap-nextd
zle -N wrap-upd
zle -N wrap-downd
bindkey '^[[1;3D' 'wrap-prevd'
bindkey '^[[1;3C' 'wrap-nextd'
bindkey '^[[1;3A' 'wrap-upd'
bindkey '^[[1;3B' 'wrap-downd'

alt-l () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="ls"
    zle accept-line -w
  fi
}
zle -N alt-l
bindkey '^[l' alt-l

alt-p () {
  if [[ $#BUFFER -eq 0 ]]; then
    zle up-history -w
  else
    old_cursor="$CURSOR"
    BUFFER="$BUFFER |& less"
    CURSOR="$old_cursor"
  fi
}
zle -N alt-p
bindkey '^[p' alt-p

alt-w () {
  cmd="$LBUFFER"
  zle push-line
  zle accept-line
  whence -v "$cmd" && whatis "$cmd"
}
zle -N alt-w
bindkey '^[w' alt-w

alt-e () {
  if [[ $#BUFFER -eq 0 ]]; then
    $EDITOR
  fi
}
zle -N alt-e
bindkey '^[e' alt-e

alt-s () {
  if [[ $#BUFFER -eq 0 ]]; then
    zle up-history -w
  fi
  BUFFER="sudo $BUFFER"
  zle end-of-line -w
}
zle -N alt-s
bindkey '^[s' alt-s
bindkey '^[h' run-help

# ALIASES
alias athenaeum '~/.local/share/flatpak/exports/bin/com.gitlab.librebob.Athenaeum'
alias cargo="mold -run cargo"
alias cat="bat"
alias c="clear"
alias e="nvim"
alias gaa="git add --all"
alias ga="git add"
alias gapa="git add --patch"
alias gap="git apply"
alias gba="git branch -a -v"
alias gban="git branch -a -v --no-merged"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gb="git branch -vv"
alias gbl="git blame -b -w"
alias gbsb="git bisect bad"
alias gbsg="git bisect good"
alias gbs="git bisect"
alias gbsr="git bisect reset"
alias gbss="git bisect start"
alias gca="git commit -a -v"
alias gcam="git commit -a -m"
alias gcav="git commit -a -v --no-verify"
alias gcb="git checkout -b"
alias gcf="git config --list"
alias gcfx="git commit --fixup"
alias gc="git commit -v"
alias gclean="git clean -di"
alias gcl="git clone"
alias gcm="git commit -m"
alias gcod="git checkout develop"
alias gco="git checkout"
alias gcount="git shortlog -sn"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"
alias gcp="git cherry-pick"
alias gcv="git commit -v --no-verify"
alias gdca="git diff --cached"
alias gd="git diff"
alias gdsc="git diff --stat --cached"
alias gds="git diff --stat"
alias gdto="git difftool"
alias gdwc="git diff --word-diff --cached"
alias gdw="git diff --word-diff"
alias gfa="git fetch --all --prune"
alias gfb="git flow bugfix"
alias gfbs="git flow bugfix start"
alias gfbt="git flow bugfix track"
alias gff="git flow feature"
alias gffs="git flow feature start"
alias gfft="git flow feature track"
alias gf="git fetch"
alias gfh="git flow hotfix"
alias gfhs="git flow hotfix start"
alias gfht="git flow hotfix track"
alias gfo="git fetch origin"
alias gfp="git flow publish"
alias gfr="git flow release"
alias gfrs="git flow release start"
alias gfrt="git flow release track"
alias gfs="git flow support"
alias gfss="git flow support start"
alias gfst="git flow support track"
alias gignore="git update-index --assume-unchanged"
alias glgga="git log --graph --decorate --all"
alias glgg="git log --graph --max-count=10"
alias glg="git log --stat --max-count=10"
alias gl="git pull"
alias gll="git pull origin"
alias glod="git log --oneline --decorate --color develop.."
alias glog="git log --oneline --decorate --color --graph"
alias glo="git log --oneline --decorate --color"
alias gloo="git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
alias glr="git pull --rebase"
alias gm="git merge"
alias gmt="git mergetool --no-prompt"
alias gp="git push"
alias gpo="git push origin"
alias gpu="ggp --set-upstream"
alias gpv="git push --no-verify"
alias gra="git remote add"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbd="git rebase develop"
alias grbdia="git rebase develop --interactive --autosquash"
alias grbdi="git rebase develop --interactive"
alias grb="git rebase"
alias grbi="git rebase --interactive"
alias grbs="git rebase --skip"
alias grev="git revert"
alias gr="git remote -vv"
alias grh="git reset"
alias grhh="git reset --hard"
alias grhpa="git reset --patch"
alias grmc="git rm --cached"
alias grm="git rm"
alias grmv="git remote rename"
alias grrm="git remote remove"
alias grset="git remote set-url"
alias grs="git restore"
alias grss="git restore --source"
alias grup="git remote update"
alias grv="git remote -v"
alias gscam="git commit -S -a -m"
alias gsd="git svn dcommit"
alias gsh="git show"
alias gsr="git svn rebase"
alias gss="git status -s"
alias gsta="git stash"
alias gstd="git stash drop"
alias gst="git status"
alias gstp="git stash pop"
alias gsts="git stash show --text"
alias gsu="git submodule update"
alias gsur="git submodule update --recursive"
alias gsuri="git submodule update --recursive --init"
alias gswc="git switch --create"
alias gsw="git switch"
alias gts="git tag -s"
alias gtv="git tag"
alias gunignore="git update-index --no-assume-unchanged"
alias gupa="git pull --rebase --autostash"
alias gupav="git pull --rebase --autostash -v"
alias gup="git pull --rebase"
alias gupv="git pull --rebase -v"
alias gwch="git whatchanged -p --alias=commit --pretty=medium"
alias less="bat"
alias ls="exa --icons"
alias ll="ls -lah"
alias la="ls -a"
alias luamake=~/.cache/nvim/nlua/sumneko_lua/lua-language-server/3rd/luamake/luamake
alias openrct2='~/.local/share/flatpak/exports/bin/io.openrct2.OpenRCT2'
alias srb2='~/.local/share/flatpak/exports/bin/org.srb2.SRB2'
alias tree="fd | tree --fromfile ."
alias t="tmux"
alias vim="nvim"
alias x='cd "$(xplr --print-pwd-as-result)"'

eval "$(antidot init)"
eval "$(zoxide init zsh --cmd d)"
eval "$(mcfly init zsh)"

source ~/.zsh/antigen.zsh
antigen theme romkatv/powerlevel10k

# Bun
export BUN_INSTALL="/home/tomvd/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen apply

[ -z "$ZPROF" ] || zprof
[[ $- == *i* ]] && instantterminalhelp
