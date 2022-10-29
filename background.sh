#!/usr/bin/env bash

# Contains all stuff which happens in background

mkdir -p ~/.ssh && sudo rm -f ~/.ssh/known_hosts
ssh-keyscan github.com > ~/.ssh/known_hosts

if [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"

    nix-env -iA nixpkgs.neovim nixpkgs.ripgrep nixpkgs.fd nixpkgs.fzf nixpkgs.fish

    sudo chsh -s "$HOME/.nix-profile/bin/fish" "$USER"

    sudo apt purge -y neovim* fish*

    fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'
    fish -c 'fisher install PatrickF1/fzf.fish'

    rm -rf "$HOME/.local/share/fish/fish_history" && rm /workspace/.fish_history && ln -s "$HOME/.local/share/fish/fish_history" /workspace/.fish_history && touch /workspace/.fish_history

    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
fi