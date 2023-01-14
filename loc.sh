#!/bin/bash
# Counts lines of code in this repo, which is (kinda) nontrivial, because of
# submodules and other cruft. Also `.config/nvim` needs to be included, so I'll
# need to enable and then filter hidden files.
#
# This is very overengineered but why not?

set -euo pipefail

# shellcheck disable=2034
# NOTE: does not apply because of usage in `var` (which apparently it doesn't
# understand)
submodule_excludes=(
    st
    dmenu
)

# shellcheck disable=2034
dependencies=(
    ack
    awk
    coreutils
    fd
    findutils
    jq
    tokei
    util-linux
)

var() {
    printf '%s' "${!1}"
}

get_submodules() {
    git submodule |
        awk '{print $2}' |
        ack -v "$(var submodule_excludes | paste -sd'|')" |
        paste -sd'|'
}

# shellcheck disable=2046
# deliberate
if ! pacman -Qi $(var dependencies) 2>/dev/null >/dev/null; then
    echo 'Installing dependencies...'
    sudo pacman -Syu --needed $(var dependencies)
fi

fd -H --type f |
    ack -v '^(st|dmenu)\/(?!config.def.h)|^.git|discord|cursors' |
    ack -v "$(get_submodules)" |
    xargs tokei -C -o json -- |
    jq 'to_entries | map({Language: .key, "Lines Of Code": .value.code})' |
    jq -r '(.[0] | keys_unsorted) as $keys | $keys, map([.[ $keys[] ]])[] | @tsv' |
    column -s$'\t' -t
