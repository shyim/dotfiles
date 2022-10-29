#!/usr/bin/env bash

# Contains all stuff which happens in background

mkdir -p ~/.ssh && touch ~/.ssh/known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts

sudo apt purge -y neovim*

wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
rm nvim-linux64.deb

sudo apt install -y ripgrep fd-find

# Ubuntu fd is weirdoo
sudo ln -s /usr/bin/fdfind /usr/bin/fd

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y