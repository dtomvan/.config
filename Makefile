dirs = awesome bins bspwm clifm discord editorconfig emacs fish git gtk i3lock kitty neovim picom rofi sxhkd tmux xmonad xorg xplr zellij zsh
root-dirs = p10k xmonad-root

all: $(dirs) $(root-dirs) st bspwmbar
	stow $(dirs)
	sudo stow $(root-dirs) -t /usr/share
	cd st && sudo make install
	cd bspwmbar && ./configure --prefix=/usr
	cd bspwmbar && sudo make bspwmbar install
