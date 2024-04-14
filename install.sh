#!/usr/bin/env bash

dotfiles_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
workspace_dir="/workspaces"

if ! which atuin; then
    tmpDir=$(mktemp -d)

    curl -q -L https://github.com/atuinsh/atuin/releases/download/v18.1.0/atuin-v18.1.0-$(uname -m)-unknown-linux-gnu.tar.gz -o "$tmpDir/atuin.tar.gz"
    curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
    tar xf "$tmpDir/atuin.tar.gz" --strip=1 -C $tmpDir
    
    if [[ ! -d /usr/local/bin ]]; then
      sudo mkdir -p /usr/local/bin
    fi
    
    sudo mv "$tmpDir/atuin" /usr/local/bin/atuin
    
    rm -rf $tmpDir
fi

if [[ ! -z "$ATUIN_USERNAME" ]]; then
    atuin login -u "$ATUIN_USERNAME" -p "$ATUIN_PASSWORD" --key "$ATUIN_KEY"
    atuin sync --force
fi

if [[ ! -d ~/.config/ ]]; then
    mkdir -p ~/.config/
fi

if ! which starship; then
    tmpDir=$(mktemp -d)

    curl -q -L https://github.com/starship/starship/releases/latest/download/starship-$(uname -m)-unknown-linux-gnu.tar.gz -o "$tmpDir/starship.tar.gz"
    tar xf "$tmpDir/starship.tar.gz" -C "$tmpDir"
    
    if [[ ! -d /usr/local/bin ]]; then
        sudo mkdir -p /usr/local/bin
    fi
    
    sudo mv "$tmpDir/starship" /usr/local/bin/starship
    
    rm -rf $tmpDir
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
