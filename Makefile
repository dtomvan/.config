dirs = backgrounds bat bins bspwm cursors deadd discord emacs erd git gtk i3lock    \
     inkscape minecraft mpd mpv ncmpcpp neovim picom polybar prismlauncher raku-bin \
     sxhkd tmux visidata wezterm xmonad xonotic xorg xplr yazi zathura zsh
usrdirs = plymouth
submodules = $(shell git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

all: pkgs rust $(dirs) $(usrdirs) install-st ~/.cargo/bin/dmenu_drun /usr/local/bin/dmenu ~/.local/bin/xwinwrap
	mkdir -p ~/projects/ ~/repos/
	pip install sqlparse inkscape-figures
	localectl set-x11-keymap us,gr "" "" compose:ralt
	git clone https://github.com/gillescastel/inkscape-shortcut-manager.git ~/repos/inkscape-shortcuts/
	bat cache --build

/usr/local/bin/dmenu: dmenu/
	cd dmenu && sudo make install

~/.cargo/bin/dmenu_drun:
	cargo install dmenu_drun

$(dirs):
	stow $@

$(usrdirs):
	sudo stow -t /usr/ $@

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
	which rustc || rustup default nightly || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

vdplus:
	pip install -r ~/.visidata/vdplus/requirements.txt

.PHONY: pkgs rust $(dirs) $(usrdirs) /usr/local/bin/dmenu ~/.cargo/bin/dmenu_drun vdplus
