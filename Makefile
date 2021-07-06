dirs = awesome picom xplr fish zsh neovim
root-dirs = p10k

all:
	stow $(dirs)
	sudo stow $(root-dirs) -t /usr/share
