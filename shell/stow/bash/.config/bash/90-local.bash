# Escape hatch for machine-local, untracked config (secrets, one-off
# aliases, work-specific env vars). Loads last so it can override anything
# above. Not part of this repo -- create it by hand on each machine.
if [[ -f "$HOME/.local_config/index.sh" ]]; then
  source "$HOME/.local_config/index.sh"
fi
