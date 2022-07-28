dirs = backgrounds bins bspwm deadd discord emacs git gtk i3lock minecraft mpd mpv ncmpcpp neovim nix picom polybar sxhkd tmux wezterm xmonad xonotic xorg xplr zsh
submodules = $(shell git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

all: pkgs rust $(dirs) install-st ~/.cargo/bin/dmenu_drun /usr/local/bin/dmenu ~/.local/bin/xwinwrap
	nix-channel --list | grep home-manager || nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --list | grep nixpkgs-unstable || nix-channel --add https://nixos.org/channels/nixpkgs-unstable
	nix-channel --update
	nix-shell '<home-manager>' -A install
	home-manager build
	home-manager switch
	nix-shell -p gcc
	nvim --headless -c PackerClean -c PackerInstall -c PackerCompile -c "qa!"
	localectl set-x11-keymap us,gr "" "" compose:ralt

/usr/local/bin/dmenu: dmenu/
	cd dmenu && sudo make install

~/.cargo/bin/dmenu_drun:
	cargo install dmenu_drun

$(dirs):
	stow $@

$(submodules):
	git submodule update --init --recursive

install-st: st
	cd st && make && sudo make install

~/.local/bin/xwinwrap: xwinwrap
	cd xwinwrap && make
	cp xwinwrap/xwinwrap ~/.local/bin
	chmod +x ~/.local/bin/xwinwrap

pkgs:
	yay -S --needed --norebuild - < pkgs.list

rust:
	which rustc || rustup default nightly

.PHONY: pkgs rust $(dirs) /usr/local/bin/dmenu ~/.cargo/bin/dmenu_drun
