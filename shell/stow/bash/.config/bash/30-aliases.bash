# Fills gaps in Omarchy's default bash aliases (see
# /usr/share/omarchy/default/bash/aliases for what's already covered --
# eza, zoxide, fzf preview, g/gcm/gcam/gcad, d, t, n).

# Editor
alias vi=nvim
alias vim=nvim

if command -v bat &>/dev/null; then
  alias cat="bat --paging=never"
fi

# Git (short names that don't collide with Omarchy's g/gcm/gcam/gcad)
alias gup="git fetch && git merge --ff-only"
alias gac="git add . && git commit"
alias gip="git push"
alias gs="git status"
alias gl="git log"
alias gb="git branch"
alias wip="git add . && git commit -m 'wip' --no-verify && git push"

glean() {
  git remote prune origin
  git branch --merged | grep -v "\*" | grep -v "develop" | grep -v "main" | grep -v "dev" | xargs -n 1 git branch -d
}

# Docker
alias docker-stop-all='docker stop $(docker ps -a -q)'
alias docker-clean=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '
alias dc='docker compose'
alias dcs='docker compose stop'

# GPG signing
signMessage() {
  echo "$1" | gpg -as
}

# PATH pretty-print
alias path='echo "${PATH//:/$'"'"'\n'"'"'}"'
