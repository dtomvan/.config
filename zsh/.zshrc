[ -z "$ZPROF" ] || zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export BROWSER=firefox
export EDITOR=nvim
export NPM_CONFIG_PREFIX=~/.npm-global
export PATH=~/.local/bin/dt/:/opt/ce-toolchain/bin/:$NPM_CONFIG_PREFIX/bin:~/.local/bin/neovim/:~/.cargo/bin:~/.local/bin:$PATH:$DENO_INSTALL/bin:~/.local/share/gem/ruby/3.0.0/bin:~/go/bin:~/.yarn/bin
export DENO_INSTALL="$HOME/.deno"
export RUSTC_WRAPPER=sccache
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
eval "$(mise activate zsh)"

fire() {
    cd "$(git rev-parse --show-toplevel)"
    cur_branch="$(git branch --show-current)"

    name="fire-$(date +%D)-$(git config user.email)-$(date +%N)"
    echo "Pushing current branch"
    git push origin $cur_branch
    echo "Stashing uncommitted changes"
    git add -A
    git stash push -m "$name"
    echo "Switching to new branch $name"
    git checkout -b $name
    echo "Applying stash"
    git stash apply
    echo "Emergency committing all changes"
    git commit -m "Fire at $(date). All changes have been committed to a seperate branch." \
      --no-verify -a
    echo "Press enter to push to new branch $name..."
    read

    for remote in $(git remote); do
      git push $remote --set-upstream --no-verify $(git branch --show-current)
      git push $remote --tags
    done

    if [ "$(git stash list)" != '' ]; then
      for sha in $(git rev-list -g stash); do
        git push --no-verify origin "$sha":refs/heads/"$cur_branch"-stash-"$sha"
      done
    fi
}

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
  tmuxinator aoc
}

filehere() {
  printf "%s/%s" $(pwd) "$1"
}

cppath() {
  filehere $@ | xsel -b
}

glogg() {
  nu -m thin -c 'git log --pretty=%h»¦«%s»¦«%aN»¦«%aE»¦«%aD | lines | split column "»¦«" commit subject name email date | upsert date {|d| $d.date | into datetime} | reject name' | bat --style 'header,grid,snip' --file-name 'git-log'
}

zle -N zle-keymap-select
zle -N zle-line-init

export MOAR='-statusbar bold -wrap'
export PAGER=bat
export BAT_THEME="Catppuccin-mocha"
export HISTFILE=~/.histfile
export HISTSIZE=500000
export SAVEHIST=500000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null || true

setopt autocd extendedglob notify globdots noflowcontrol
unsetopt beep
bindkey -v
source ~/.profile

# if [[ -f ~/pacman@*.log(#qN) ]]; then
#     read -q "REVIEW?You have remaining pacman logs, review them?"
#     if [[ "$REVIEW" == "y" ]]; then
#         nvim ~/pacman*.log
#     fi
# fi

eval "$(zoxide init zsh --cmd z)"

autoload -U compinit # promptinit

# promptinit
# prompt pure

compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
fpath=(/usr/local/share/zsh-completions $fpath)

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
bindkey -M vicmd '^v' edit-command-line

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

alias :w="cowsay 'You are not in vim anymore.'"
alias :q="cowsay 'You are not in vim anymore.'"
alias :wq="cowsay 'You are not in vim anymore.'"
alias :x="cowsay 'You are not in vim anymore.'"

alias v='nvim'
alias vi='nvim'
alias nvi='nvim'
alias nv='nvim'
alias vim='nvim'
alias vimm='nvim'
alias nvimm='nvim'

j() {
    mise x just -- just $@ 
}
alias mr="mise run"

alias sl='ls'

alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'
cx () {
    cd $1
    eza -lab --git --no-user || /bin/ls -la
}

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

run-tmux() {
  BUFFER="tmux"
  zle accept-line -w
}
zle -N run-tmux
bindkey '^[t' run-tmux

tex() {
  pushd ~/projects/tex/
  cd $(fd --type d | sk --preview='ls -la {}' -1 -0 || echo .)
}

gcommit() {
    gum confirm "Do you want to stage anything?" && git add -i
    echo 'What change did you make?'
    choose=`gum choose fix feat docs style refactor test chore`
    echo 'Any scope?'
    scope=`gum input --placeholder scope`
    [ -n "$scope" ] && scope="($scope)"
    summary=`gum input --placeholder "Describe what you changed in ~20 words" || return`

    git status -s
    gum confirm "Commit changes?" && git commit -m "$choose$scope: $summary" -e
}

scronie() {
    sudo EDITOR="$EDITOR" fcrontab -e
}

nvr() {
    whence -vps nvim
    echo
    tr ":\n" "\\000" <<< "$PATH" | xargs -0r -I{} -n1 find {} -maxdepth 1 -executable -name 'nvim' 2>/dev/null | xargs -I{} sh -c 'echo "path: {}"; {} --version | head -n4'
}

# Dotfiles-commit
dfc() {
    git add -A && git commit -m "$(date +%F)"
}

deref() {
    if [ -h "$1" ] ; then
        target="$(readlink $1)"
        rm "$1"
        cp "$target" "$1"
    fi
}

dragfile() {
    sk -c fd -m "$SKIM_ARGS" | xargs -r ripdrag "$DRAG_ARGS"
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
# ALIASES
alias rat=bat
alias matt=bat
alias athenaeum '~/.local/share/flatpak/exports/bin/com.gitlab.librebob.Athenaeum'
# alias cargo="mold -run cargo"
alias cat="bat"
alias e="nvim"
alias g=git
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
alias luamake=~/.cache/nvim/nlua/sumneko_lua/lua-language-server/3rd/luamake/luamake
alias openrct2='~/.local/share/flatpak/exports/bin/io.openrct2.OpenRCT2'
alias srb2='~/.local/share/flatpak/exports/bin/org.srb2.SRB2'
alias tree="fd | tree --fromfile ."
alias t="tmux"
alias vim="nvim"
alias x='cd "$(xplr --print-pwd-as-result)"'

alias templeos="printf '\\33]50;%s\\007' 'xft:TempleOS-12,Iosevka Nerd Font-18' && nvim +Temple && printf '\\33]50;%s\\007' 'xft:Iosevka Nerd Font-15'"

rwds_export() {
    for var in $@
    do
    rwds-cli show -p "$var" | awk -F'\t' '/^\s*$/ { p=1;next }p {print $1, "\t",$2}'
    done
}

#eval "$(antidot init)"
#eval "$(mcfly init zsh)"

# Bun
export BUN_INSTALL="/home/tomvd/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh" || return
[[ ! -r /home/tomvd/.opam/opam-init/init.zsh ]] || source /home/tomvd/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

eval "$($(mise which starship) init zsh)"
plug "zap-zsh/supercharge"
# plug "romkatv/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zvm_after_init_commands+=(eval "$(atuin init zsh --disable-up-arrow)")
plug "jeffreytse/zsh-vi-mode"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"

[ -z "$ZPROF" ] || zprof

alias ls="eza --icons"
alias ll="ls -lah"
alias la="ls -a"

_exa() {
    _eza "$@"
}

c() {
  echo "$@" | rink
}

xon() {
    exec $(fd -HiLt x -d 2 'xonotic-linux-sdl' | head -n1)
}

# pnpm
export PNPM_HOME="/home/tomvd/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=0
fi


# bun completions
[ -s "/home/tomvd/.bun/_bun" ] && source "/home/tomvd/.bun/_bun"
alias dt="rlwrap dt"
# eval "$(navi widget zsh | sed -Ee 's|--print|\0 --finder skim|g')"

PATH="/home/tomvd/.raku/bin:/home/tomvd/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/tomvd/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/tomvd/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/tomvd/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/tomvd/perl5"; export PERL_MM_OPT;

. "$HOME/.atuin/bin/env"
