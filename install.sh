#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/.omarchy-config"
DOTFILES_REPO="https://github.com/CrowderSoup/omarchy-config.git"

echo "==> Starting omarchy-config installation..."

if [[ -d "$DOTFILES_DIR" ]]; then
  echo "==> Updating existing checkout..."
  git -C "$DOTFILES_DIR" pull
else
  echo "==> Cloning omarchy-config..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

bash "$DOTFILES_DIR/setup.sh"
