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

get_submodules() {
    git submodule |
        awk '{print $2}' |
        ack -v "$(printf "%s" "${submodule_excludes[@]}" | paste -sd'|')" |
        paste -sd'|'
}

archdeps "${dependencies[@]}"

fd -H --type f |
    ack -v '^(st|dmenu)\/(?!config.def.h)|^.git|discord|cursors|mpv/.config/mpv/scripts/uosc.lua' |
    ack -v "$(get_submodules)" |
    xargs tokei -C -o json -- |
    jq '.Markdown.code += .Markdown.comments | .["Plain Text"].code += .["Plain Text"].comments' |
    jq 'to_entries | map({Language: .key, "Lines Of Code": .value.code})' |
    jq -r 'sort_by(.["Lines Of Code"]) | (.[0] | keys_unsorted) as $keys | $keys, map([.[ $keys[] ]])[] | @tsv' |
    column -s$'\t' -t -o $'\t'
