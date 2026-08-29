# Omarchy's default bash already puts ~/.local/bin on PATH.
# Add workspace-specific paths that aren't covered by defaults.

if [[ -d "$HOME/Projects/go" ]]; then
  export GOPATH="$HOME/Projects/go"
  case ":$PATH:" in
    *":$GOPATH/bin:"*) ;;
    *) export PATH="$PATH:$GOPATH/bin" ;;
  esac
fi

if [[ -d "$HOME/.cargo/bin" ]]; then
  case ":$PATH:" in
    *":$HOME/.cargo/bin:"*) ;;
    *) export PATH="$PATH:$HOME/.cargo/bin" ;;
  esac
fi
