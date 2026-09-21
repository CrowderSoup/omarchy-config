#!/bin/bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"

echo "==> Setting up omarchy-config..."

if ! command -v omarchy &>/dev/null; then
  echo "ERROR: this repo assumes an Omarchy machine (the 'omarchy' command wasn't found)." >&2
  echo "The shell/ layer's files are plain dotfiles and can be stowed by hand elsewhere," >&2
  echo "but packages.sh and the omarchy/ layer need Omarchy." >&2
  exit 1
fi

echo "==> Installing packages..."
bash "$REPO/packages.sh"

stow_layer() {
  local layer_dir="$1"
  [[ -d "$layer_dir" ]] || return 0
  cd "$layer_dir"
  for pkg in */; do
    pkg="${pkg%/}"
    declare -A handled_parents=()
    while IFS= read -r -d '' filepath; do
      rel="${filepath#"$pkg"/}"
      dest="$HOME/$rel"
      parent="$(dirname "$dest")"

      if [[ -L "$parent" ]]; then
        # Stow already folded this whole directory into a single symlink (on
        # an earlier run, or from something else). Reaching through it and
        # inspecting individual "files" would actually operate on whatever
        # the symlink points at -- possibly this very repo -- so handle it
        # once at the directory level and never look at files under it.
        if [[ -z "${handled_parents[$parent]:-}" ]]; then
          handled_parents[$parent]=1
          if ! readlink "$parent" | grep -q "$pkg/"; then
            echo "  -> removing old directory symlink $parent (was -> $(readlink "$parent"))"
            rm "$parent"
          fi
        fi
        continue
      fi

      if [[ -L "$dest" ]] && ! readlink "$dest" | grep -q "$pkg/"; then
        # Symlink stow doesn't own (e.g. from an old dotfiles setup)
        echo "  -> removing old symlink $dest (was -> $(readlink "$dest"))"
        rm "$dest"
      elif [[ -e "$dest" && ! -L "$dest" ]]; then
        # Real file already there (e.g. Omarchy's shipped default) -- keep it, just move it aside
        backup="$dest.bak.$(date +%s)"
        echo "  -> backing up existing $dest -> $backup"
        mv "$dest" "$backup"
      fi
    done < <(find "$pkg" -type f -print0)
    unset handled_parents
    echo "  -> stow $pkg"
    stow -v --target="$HOME" --restow "$pkg"
  done
}

echo "==> Stowing shell config..."
stow_layer "$REPO/shell/stow"

echo "==> Stowing omarchy config..."
stow_layer "$REPO/omarchy/stow"

# Stowing the idle plugin only drops its files in place; enabling it (and turning
# off the stock one it replaces) is recorded in shell.json, which isn't stowed.
if [[ -d "$HOME/.config/omarchy/plugins/crowdersoup.idle" ]]; then
  echo "==> Enabling crowdersoup.idle (screensaver in Foot)..."
  omarchy plugin enable crowdersoup.idle || true
  omarchy plugin disable omarchy.idle || true
fi

# Wire the bash modules into Omarchy's user section of ~/.bashrc, once.
MARKER="# omarchy-config: load ~/.config/bash/*.bash"
if ! grep -qF "$MARKER" "$HOME/.bashrc" 2>/dev/null; then
  echo "==> Hooking bash modules into ~/.bashrc..."
  {
    echo ""
    echo "$MARKER"
    echo 'for f in "$HOME/.config/bash/"*.bash; do source "$f"; done'
  } >>"$HOME/.bashrc"
fi

# Configure git to use delta, if it's installed.
if command -v delta &>/dev/null && [[ -f "$HOME/.config/git/config-delta" ]]; then
  git config --global include.path ~/.config/git/config-delta
  echo "  -> git delta config included"
fi

echo "==> Done! Open a new shell (or 'source ~/.bashrc') to pick up the changes."
