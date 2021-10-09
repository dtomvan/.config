dirs = awesome bins clifm discord editorconfig emacs fish git gtk i3lock kitty neovim picom tmux xmonad xorg xplr zellij zsh
root-dirs = p10k xmonad-root

all: $(dirs) $(root-dirs) st
	stow $(dirs)
	sudo stow $(root-dirs) -t /usr/share
	cd st && sudo make install
