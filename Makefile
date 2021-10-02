dirs = awesome picom xplr fish zsh neovim editorconfig git xmonad gtk bins i3lock discord zellij tmux kitty clifm
root-dirs = p10k xmonad-root

all: $(dirs) $(root-dirs) st
	stow $(dirs)
	sudo stow $(root-dirs) -t /usr/share
	cd st && sudo make install
