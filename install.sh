#!/usr/bin/env bash

curl -sS https://starship.rs/install.sh | sh -s -- -f

cp ~/.dotfiles/.gitconfig ~/.gitconfig
cp ~/.dotfiles/.wakatime.cfg ~/.wakatime.cfg
cp ~/.dotfiles/.bashrc.d/* ~/.bashrc.d/

mkdir -p ~/.ssh && touch ~/.ssh/known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts
