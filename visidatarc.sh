#!/bin/bash
# This file exists for the purpose of keeping my Reddit API keys safe. The rest
# of my RC are a bunch of logical imports for scripting, so isn't really useful
# to anyone but me anyways.

RC=.visidatarc.gpg

case "$1" in
	"decrypt" )
		gpg --decrypt --output ~/.visidatarc "$RC"
		;;
	"encrypt" )
		gpg --encrypt --armor --output "$RC" --recipient '18gatenmaker6@gmail.com' ~/.visidatarc
		;;
	"install" )
		git clone https://aur.archlinux.org/keybase-bin ~/.cache/keybase-install
		cd ~/.cache/keybase-install
		sudo pacman -S --needed --noconfirm base-devel
		makepkg -si
		;;
	"get-key" )
		run_keybase
		gpg --import /keybase/private/dtomvan/pub
		gpg --import /keybase/private/dtomvan/privkey
		expect -c 'spawn gpg --edit-key 7A984C8207ADBA51 trust quit; send "5\ry\r"; expect eof'
		;;
	*) echo >&2 "No such operation: $@"; exit 1;;
esac
