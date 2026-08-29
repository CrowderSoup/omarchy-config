# Omarchy wires up fzf's key bindings and completion already. Point the
# default search commands at fd so they respect .gitignore and find hidden
# files, instead of falling back to `find`.
if command -v fzf &>/dev/null && command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi
