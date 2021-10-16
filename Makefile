dirs = awesome bins bspwm clifm discord editorconfig emacs fish git gtk i3lock kitty neovim picom rofi sxhkd tmux xmonad xorg xplr zellij zsh
root-dirs = p10k xmonad-root
submodules = $(shell git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

all: $(dirs) $(root-dirs) .st /usr/local/bin/bspwmbar .xmonad
	stow $(dirs)
	localectl set-x11-keymap us "" "" compose:ralt
	sudo stow $(root-dirs) -t /usr/share

$(submodules):
	git submodule update --recursive

.xmonad: xmonad/.xmonad
	cd xmonad/.xmonad && stack install

/usr/local/bin/bspwmbar: bspwmbar
	cd bspwmbar && ./configure --prefix=/usr
	cd bspwmbar && sudo make bspwmbar
	@cd bspwmbar && sudo make install || echo "Could not copy bspwmbar, continueing"

.st: st
	cd st && sudo make install
