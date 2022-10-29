#!/usr/bin/env bash

curl -sS https://starship.rs/install.sh | sh -s -- -f

cp ~/.dotfiles/.wakatime.cfg ~/.wakatime.cfg
cp ~/.dotfiles/.bashrc.d/* ~/.bashrc.d/
cp ~/.dotfiles/.gitconfig ~/.gitconfig

if [[ "$USER" == "gitpod" ]]; then
    echo "[credential]" >> ~/.gitconfig
    echo "    helper = /usr/bin/gp credential-helper" >> ~/.gitconfig
fi

nohup bash ~/.dotfiles/background.sh
