#!/bin/bash

set -euo

mkdir -p ~/repos/neovim/ ~/.local/bin/neovim/
if ! [[ ":$PATH:" == *":$HOME/.local/bin/neovim:"* ]]; then
    echo "Your path is missing ~/.local/bin/neovim, you might want to add it."
fi

[ -d ~/repos/neovim/ ] || (git clone https://github.com/neovim/neovim.git ~/repos/neovim)

pushd ~/repos/neovim

# Build
git pull
git clean -fxd
make CMAKE_BUILD_TYPE=Release

# Install Neovim runtime
sudo make install || echo "Couldn't install Neovim runtime, check for errors. Your installation will not function properly."

# Install locally
date="$(date +%y%m%d)"
tag="$(git describe)"

cp build/bin/nvim ~/.local/bin/neovim/nvim-"$date"-"$tag"
if [ -h ~/.local/bin/neovim/nvim ]; then
    rm ~/.local/bin/neovim/nvim
else
    echo "\~/.local/bin/neovim/nvim is not a symlink, keeping it."
    exit
fi
ln -s ~/.local/bin/neovim/nvim-"$date"-"$tag" ~/.local/bin/neovim/nvim

echo "Installed Neovim version:"

popd
