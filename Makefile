dirs = backgrounds bins bspwm deadd discord editorconfig emacs fish git gtk i3lock mpd mpv ncmpcpp neovim picom rofi sxhkd tmux wezterm xorg xplr zellij zsh
root-dirs = xmonad-root
submodules = $(shell git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

all: $(dirs) $(root-dirs) discord_arch_electron st /usr/local/bin/bspwmbar xmonad ~/.local/bin/sheldon ~/.config/rofi rofisettings ~/.cargo/bin/dmenu_drun /usr/local/bin/dmenu ~/.local/bin/xwinwrap
	localectl set-x11-keymap us,gr "" "" compose:ralt

/usr/local/bin/dmenu: dmenu/
	cd dmenu && sudo make install

~/.cargo/bin/dmenu_drun: dmenu_drun/
	cargo install --path dmenu_drun

~/.local/bin/sheldon:
	curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin

$(dirs):
	stow $@

$(root-dirs):
	sudo stow $@ -t /usr/share

$(submodules):
	git submodule update --init --recursive

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

~/.config/rofi: rofi
	cd rofi && chmod +x setup.sh && ./setup.sh

mvrofi:
	mv ~/.config/rofi ~/.config/rofi.old

rofisettings:
	stow --adopt rofisettings

~/.local/bin/xwinwrap: xwinwrap
	cd xwinwrap && make
	cp xwinwrap/xwinwrap ~/.local/bin
	chmod +x ~/.local/bin/xwinwrap

.PHONY: $(dirs) $(root-dirs) discord_arch_electron st mvrofi rofisettings /usr/local/bin/dmenu ~/.cargo/bin/dmenu_drun
