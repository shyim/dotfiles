#!/usr/bin/env bash

dotfiles_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
workspace_dir="/workspaces"

if [[ ! -d ~/.bashrc.d/ ]]; then
    mkdir -p ~/.bashrc.d/
    echo 'for i in $(ls -A $HOME/.bashrc.d/); do source $HOME/.bashrc.d/$i; done' >> "$HOME/.bashrc"
fi

if [[ ! -d ~/.config/ ]]; then
    mkdir -p ~/.config/
fi

curl -sS https://starship.rs/install.sh | sh -s -- -f

cp $dotfiles_dir/.wakatime.cfg ~/.wakatime.cfg
cp $dotfiles_dir/.bashrc.d/* ~/.bashrc.d/
cp -r $dotfiles_dir/.config/* ~/.config/

if [[ "$USER" == "gitpod" ]]; then
    workspace_dir="/workspace"

    # Only on Gitpod is Git Config annoying
    cp $dotfiles_dir/.gitconfig ~/.gitconfig

    echo "[credential]" >> ~/.gitconfig
    echo "    helper = /usr/bin/gp credential-helper" >> ~/.gitconfig
fi

if command -v python3 &> /dev/null
then
    mkdir -p ~/.hishtory || true
    mkdir -p "${workspace_dir}/.hishtory" || true
    ln -s "${workspace_dir}/.hishtory" "$HOME/.hishtory"

    curl https://hishtory.dev/install.py | python3 -
fi

export dotfiles_dir
export workspace_dir

nohup bash "$dotfiles_dir/background.sh" &
