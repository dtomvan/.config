dirs = backgrounds bins bspwm deadd discord emacs git gtk i3lock minecraft mpd mpv ncmpcpp neovim nix picom polybar sxhkd tmux wezterm xmonad xorg xplr zellij zsh
submodules = $(shell git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

all: $(dirs) st ~/.cargo/bin/dmenu_drun /usr/local/bin/dmenu ~/.local/bin/xwinwrap
	yay -S --needed - < pkgs.list
	nix-channel --list | grep home-manager || nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
	home-manager build
	home-manager switch
	nvim --headless -c PackerClean -c PackerInstall -c PackerCompile -c "qa!"
	localectl set-x11-keymap us,gr "" "" compose:ralt

/usr/local/bin/dmenu: dmenu/
	cd dmenu && sudo make install

~/.cargo/bin/dmenu_drun:
	cargo install dmenu_drun

$(dirs):
	stow $@

$(root-dirs):
	sudo stow $@ -t /usr/share

$(submodules):
	git submodule update --init --recursive

st: st/
	cd st && sudo make install

~/.local/bin/xwinwrap: xwinwrap
	cd xwinwrap && make
	cp xwinwrap/xwinwrap ~/.local/bin
	chmod +x ~/.local/bin/xwinwrap

.PHONY: $(dirs) $(root-dirs) st /usr/local/bin/dmenu ~/.cargo/bin/dmenu_drun
