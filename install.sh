#!/usr/bin/env bash

dotfiles_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
workspace_dir="/workspaces"

if [[ ! -z "$ATUIN_USERNAME" ]]; then
    bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
    atuin login -u "$ATUIN_USERNAME" -p "$ATUIN_PASSWORD" --key "$ATUIN_KEY"
    atuin sync --force

    touch ~/.config/atuin/config.toml
    echo "sync_frequency = \"1m\"" >> ~/.config/atuin/config.toml
fi

if [[ ! -d ~/.config/ ]]; then
    mkdir -p ~/.config/
fi

curl -sS https://starship.rs/install.sh | sh -s -- -f

cp $dotfiles_dir/.wakatime.cfg ~/.wakatime.cfg
cp $dotfiles_dir/.bashrc ~/.bashrc
cp $dotfiles_dir/.bashrc.d/* ~/.bashrc.d/
cp -r $dotfiles_dir/.config/* ~/.config/

if [[ "$USER" == "gitpod" ]]; then
    workspace_dir="/workspace"

    # Only on Gitpod is Git Config annoying
    cp $dotfiles_dir/.gitconfig ~/.gitconfig

    echo "[credential]" >> ~/.gitconfig
    echo "    helper = /usr/bin/gp credential-helper" >> ~/.gitconfig
fi

if which apt; then
    sudo apt update
    # missing in codespaces
    sudo apt install -y bash-completion
fi
