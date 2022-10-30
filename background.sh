#!/usr/bin/env bash

# Contains all stuff which happens in background

mkdir -p ~/.ssh && sudo rm -f ~/.ssh/known_hosts
ssh-keyscan github.com > ~/.ssh/known_hosts

if [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"

    nix-env -iA nixpkgs.neovim nixpkgs.ripgrep nixpkgs.fd nixpkgs.fzf nixpkgs.fish nixpkgs.starship

    sudo chsh -s "$HOME/.nix-profile/bin/fish" "$USER"

    sudo apt purge -y neovim* fish*

    fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'
    fish -c 'fisher install PatrickF1/fzf.fish'

    rm -f "$HOME/.local/share/fish/fish_history" && ln -s /workspace/.fish_history "$HOME/.local/share/fish/fish_history"
    sudo cp "$HOME/.nix-profile/bin/fish" /usr/bin/fish

    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
fi