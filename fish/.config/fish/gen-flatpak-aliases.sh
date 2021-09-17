#!/bin/bash

declare -A aliases

for bin in ~/.local/share/flatpak/exports/bin/*; do
	appid="$(basename $bin)"
	cmd="$(flatpak info -m $appid | awk -F= '/^command=/ {print $2}')"

	[[ -z $cmd ]] && continue
	aliases[$appid]="$(basename ${cmd##*/})"
done

(
for appid in "${!aliases[@]}"; do
	echo "alias ${aliases[$appid]}=~/.local/share/flatpak/exports/bin/$appid"
done
)
