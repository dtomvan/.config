dirs = awesome bins bspwm clifm discord editorconfig emacs fish git gtk i3lock kitty neovim picom rofi sxhkd tmux xorg xplr zellij zsh
root-dirs = p10k xmonad-root
submodules = $(shell git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

all: $(dirs) $(root-dirs) discord_arch_electron st /usr/local/bin/bspwmbar xmonad
	localectl set-x11-keymap us "" "" compose:ralt

$(dirs):
	stow $@

$(root-dirs):
	sudo stow $@ -t /usr/share

$(submodules):
	git submodule update --recursive

discord_arch_electron:
	cd $@ && makepkg -si

xmonad: xmonad/.xmonad
	stow $@
	cd xmonad/.xmonad && stack install

/usr/local/bin/bspwmbar: bspwmbar
	cd bspwmbar && ./configure --prefix=/usr
	cd bspwmbar && sudo make bspwmbar
	@cd bspwmbar && sudo make install || echo "Could not copy bspwmbar, continueing"

st: st/
	cd st && sudo make install

.PHONY: $(dirs) $(root-dirs) discord_arch_electron
