#!/usr/bin/env bash

# Setup dotfiles

set -euo pipefail

if ! command -v nix-channel &> /dev/null
then
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

export NIX_PATH=$HOME/.nix-defexpr/channels:${NIX_PATH:+:$NIX_PATH}

nix-shell '<home-manager>' -A install

git clone https://github.com/shyim/darwin-nix.git ~/.nix || true

# Delete direnv
nix-env -e direnv || true

# Delete default gitconfig
rm -f ~/.gitconfig

cat << EOF > ~/.config/nixpkgs/home.nix
{ config, pkgs, ... }:

{
  imports = [
    ${HOME}/.nix/home/home.nix
  ];
 
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${USER}";
  home.homeDirectory = ${HOME};

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
EOF

home-manager switch

sudo chsh -s /home/gitpod/.nix-profile/bin/fish "$USER"
