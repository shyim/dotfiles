#!/usr/bin/env bash

dotfiles_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
workspace_dir="/workspaces"

if [[ ! -z "$ATUIN_USERNAME" ]]; then
    bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
    atuin login -u "$ATUIN_USERNAME" -p "$ATUIN_PASSWORD" --key "$ATUIN_KEY"
    atuin sync --force
fi

if [[ ! -d ~/.config/ ]]; then
    mkdir -p ~/.config/
fi

if ! which starship; then
    curl -L https://github.com/starship/starship/releases/latest/download/starship-$(uname -m)-unknown-linux-gnu.tar.gz -o /tmp/starship.tar.gz
    tar xvf /tmp/starship.tar.gz -C /tmp
    
    if [[ ! -d /usr/local/bin ]]; then
      sudo mkdir -p /usr/local/bin
    fi
    
    sudo mv /tmp/starship /usr/local/bin/starship
fi

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
