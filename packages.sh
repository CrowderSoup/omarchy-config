#!/bin/bash
set -euo pipefail

# Most of the "modern CLI" toolkit (eza, bat, fd, ripgrep, zoxide, fzf,
# starship, mise, tldr, neovim, jq, gnupg, lazygit) already ships as part of
# Omarchy's own defaults. This only adds what Omarchy doesn't install.

echo "==> Installing core packages..."
omarchy pkg add \
  git-delta \
  stow \
  wezterm \
  glow \
  go-yq

# Optional extras from the old macOS setup that aren't essential dotfiles
# tooling. Uncomment what you want -- some of these are AUR-only and may not
# have prebuilt binaries for non-x86_64 hardware, so check before relying on
# this on ARM.
#
# echo "==> Installing optional AUR extras..."
# omarchy pkg aur add \
#   doctl-bin \
#   bitwarden-cli \
#   localsend-bin \
#   visual-studio-code-bin

# Docker has a dedicated Omarchy installer instead of a raw package list:
#   omarchy install docker
