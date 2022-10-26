#!/usr/bin/env bash

curl -sS https://starship.rs/install.sh | sh -s -- -f

cp ~/.dotfiles/.gitconfig ~/.gitconfig
cp ~/.dotfiles/.wakatime.cfg ~/.wakatime.cfg
cp ~/.dotfiles/.bashrc.d/* ~/.bashrc.d/
