#!/usr/bin/env bash

# Contains all stuff which happens in background

mkdir -p ~/.ssh && sudo rm -f ~/.ssh/known_hosts
ssh-keyscan github.com > ~/.ssh/known_hosts

if [[ ! -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
fi

. "$HOME/.nix-profile/etc/profile.d/nix.sh"

nix-env -iA nixpkgs.neovim nixpkgs.ripgrep nixpkgs.fd

if [[ ! -z "$TAILSCALE_TOKEN" && -f /usr/sbin/tailscaled ]]; then
    sudo /usr/sbin/tailscaled &
    sudo /usr/bin/tailscale up --auth-key "$TAILSCALE_TOKEN" --operator=$USER
fi
