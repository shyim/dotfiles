#!/usr/bin/env bash

# Contains all stuff which happens in background

mkdir -p ~/.ssh && sudo rm -f ~/.ssh/known_hosts
ssh-keyscan github.com > ~/.ssh/known_hosts

sudo apt purge -y neovim* fish*

nix-env -iA nixpkgs.neovim nixpkgs.ripgrep nixpkgs.fd nixpkgs.fzf nixpkgs.fish

sudo chsh -s "$HOME/.nix-profile/bin/fish" "$USER"

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y