dirs = awesome picom xplr fish zsh neovim editorconfig git xmonad gtk bins
root-dirs = p10k xmonad-root

all:
	stow $(dirs)
	sudo stow $(root-dirs) -t /usr/share
