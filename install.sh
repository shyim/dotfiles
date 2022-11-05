#!/usr/bin/env bash

dotfiles_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
workspace_dir="/workspaces"


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

if command -v fish &> /dev/null
then
    echo "Setting up Fish"

    touch "${workspace_dir}/.fish_history"

    # Setup a History forwarder to save fish config between runs
    if [[ -d /workspace ]]; then
        mkdir -p "$HOME/.local/share/fish"
        rm -f "$HOME/.local/share/fish/fish_history" && ln -s "${workspace_dir}/.fish_history" "$HOME/.local/share/fish/fish_history"
        
        echo "Configured history forwarder"
    fi

    sudo chsh -s $(which fish) "$USER"
fi

export dotfiles_dir
export workspace_dir

nohup bash "$dotfiles_dir/background.sh" &
