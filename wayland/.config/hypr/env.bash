set -euo pipefail
shopt -s expand_aliases

socket="/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

alias listen="nc -U $socket"
alias h=hyprctl
alias hb='hyprctl --batch'
alias hd='hyprctl dispatch'
alias hn='hyprctl notify'

yell() {
    hn 3 5000 0 "$@"
}

bail() {
    yell "$@"; exit
}

warn() {
    hn 0 5000 0 "$@"
}

info() {
    hn 1 5000 0 "$@"
}

hint() {
    hn 2 2000 0 "$@"
}

getworkspace() {
    eval $1="$(hyprctl activeworkspace -j | jq -r '.name')"
}
