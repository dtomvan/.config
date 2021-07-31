dirs = awesome picom xplr fish zsh neovim editorconfig
root-dirs = p10k

all:
	stow $(dirs)
	sudo stow $(root-dirs) -t /usr/share
