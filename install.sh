#!/usr/bin/env bash

curl -sS https://starship.rs/install.sh | sh -s -- -f

cp ~/.dotfiles/.wakatime.cfg ~/.wakatime.cfg
cp ~/.dotfiles/.bashrc.d/* ~/.bashrc.d/

mkdir -p ~/.ssh && touch ~/.ssh/known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts

# Setup neovim

sudo apt purge -y neovim*

wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
rm nvim-linux64.deb

sudo apt install -y ripgrep fd-find

nohup bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y &


# Has to be as last because it's fucks any git clone

cp ~/.dotfiles/.gitconfig ~/.gitconfig
