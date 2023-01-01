dirs = backgrounds bins bspwm deadd discord emacs git gtk i3lock inkscape            \
	minecraft mpd mpv ncmpcpp neovim picom polybar sxhkd tmux visidatawezterm xmonad \
	xonotic xorg xplr zsh
submodules = $(shell git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

all: pkgs rust $(dirs) install-st ~/.cargo/bin/dmenu_drun /usr/local/bin/dmenu ~/.local/bin/xwinwrap
	mkdir -p ~/projects/ ~/repos/
	pip install sqlparse inkscape-figures
	nvim --headless -c PackerClean -c PackerInstall -c PackerCompile -c "qa!"
	localectl set-x11-keymap us,gr "" "" compose:ralt
	git clone https://github.com/gillescastel/inkscape-shortcut-manager.git ~/repos/inkscape-shortcuts/

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
	which rustc || rustup default nightly || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

vdplus:
	pip install -r ~/.visidata/vdplus/requirements.txt

.PHONY: pkgs rust $(dirs) /usr/local/bin/dmenu ~/.cargo/bin/dmenu_drun vdplus
