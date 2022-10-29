#!/usr/bin/env bash

curl -sS https://starship.rs/install.sh | sh -s -- -f

cp ~/.dotfiles/.wakatime.cfg ~/.wakatime.cfg
cp ~/.dotfiles/.bashrc.d/* ~/.bashrc.d/
cp ~/.dotfiles/.gitconfig ~/.gitconfig
cp -r ~/.dotfiles/.config/* ~/.config/

if [[ "$USER" == "gitpod" ]]; then
    echo "[credential]" >> ~/.gitconfig
    echo "    helper = /usr/bin/gp credential-helper" >> ~/.gitconfig
fi

if command -v fish &> /dev/null
then
    echo "Setting up Fish"
    # Setup a History forwarder to save fish config between runs
    if [[ -d /workspace ]]; then
        rm -rf "$HOME/.local/share/fish/fish_history" && rm /workspace/.fish_history && ln -s "$HOME/.local/share/fish/fish_history" /workspace/.fish_history && touch /workspace/.fish_history
        
        echo "Configured history forwarder"
    fi

    sudo chsh -s $(which fish) "$USER"
fi

nohup bash ~/.dotfiles/background.sh &
