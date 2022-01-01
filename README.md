# Dotfiles
To use (make sure you have stow installed):
```sh
git clone --recursive https://github.com/dtomvan/.config.git ~/Dotfiles
cd ~/Dotfiles
yay -S --needed - < pkgs.list # To install everything you need to use these dotfiles, hopefully
make # Or `make ANY_DIRECTORY` if you want to only stow/build 1 directory.
```
- For powerlevel10k, stow to /usr/local as root. (The Makefile already does that)
