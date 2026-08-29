# omarchy-config

Personal config for [Omarchy](https://omarchy.org/) machines, managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/CrowderSoup/omarchy-config/main/install.sh | bash
```

This will:
1. Clone this repo to `~/.omarchy-config`
2. Install missing packages via `omarchy pkg add`
3. Symlink configs into place with Stow
4. Hook the bash modules into `~/.bashrc`'s user section

## Manual setup

```bash
git clone https://github.com/CrowderSoup/omarchy-config.git ~/.omarchy-config
cd ~/.omarchy-config
./setup.sh
```

## Updating

```bash
cd ~/.omarchy-config && git pull && ./setup.sh
```

## Structure

Two layers, so the `shell/` layer can move to a non-Omarchy Linux box (or
back to macOS) without dragging Hyprland config with it.

```
├── install.sh          # Remote bootstrap (curl | bash)
├── setup.sh             # Installs packages, stows both layers
├── packages.sh          # Packages Omarchy doesn't already ship
├── shell/                # Portable: shell, prompt, git, terminal
│   └── stow/
│       ├── bash/          # Modular ~/.config/bash/*.bash, loaded from .bashrc
│       ├── git/            # delta integration (opt-in via git config include.path)
│       ├── starship/       # Prompt config
│       └── wezterm/        # Terminal config (static Tokyo Night, see note below)
└── omarchy/              # Omarchy-only: Hyprland overrides + default terminal
    └── stow/
        ├── hypr/           # bindings.lua, input.lua overrides
        └── xdg-terminal/   # xdg-terminals.list -> WezTerm
```

## What's here vs. what Omarchy already gives you

Omarchy's default bash (`/usr/share/omarchy/default/bash/`) already covers a
lot of ground on its own: eza aliases, a `zd`/zoxide `cd` override, fzf with
bat/kitty previews, starship + mise activation, and short git/docker aliases
(`g`, `gcm`, `d`, `t`, `n`...). This repo only adds what's missing on top of
that, rather than duplicating it:

- **Shell** — a different set of git shortcuts (`gs`, `gl`, `gb`, `gup`,
  `wip`, `glean`), docker cleanup helpers, `vi`/`vim` → `nvim`, `cat` → `bat`,
  a `GOPATH`/cargo `PATH` addition, and fd-backed `FZF_*` search commands.
- **Git** — delta side-by-side diffs (Omarchy's own git defaults already
  cover the aliases/rebase/rerere settings this used to set up by hand).
- **Prompt** — Omarchy's starship look (bold cyan, arrow prompt) plus
  language-runtime segments and a command-duration indicator.
- **Terminal** — WezTerm with a static Tokyo Night scheme. Note: Omarchy's
  theme switcher (`omarchy theme set`) repaints alacritty/foot/ghostty/kitty
  automatically but has no WezTerm template, so this terminal's colors won't
  follow along if you switch Omarchy themes.
- **Hyprland** — a couple of small personal overrides (move-window-to-monitor
  bindings, natural scrolling) and setting WezTerm as the default terminal
  for SUPER+RETURN / `xdg-terminal-exec`. See `omarchy/README.md` for what
  was deliberately left out (monitor layout, app-specific autostarts, bar
  tweaks) because it's too machine-specific to be worth templating.

Runtime versions (`mise use --global ...`) aren't managed by this repo on
purpose — that's live, per-machine state, not really a "dotfile."

## Requirements

- An Omarchy install (`packages.sh` and the `omarchy/` layer both assume the
  `omarchy` CLI is present). The `shell/stow/` files themselves are plain
  dotfiles and can be stowed by hand on any Linux/macOS box.

## Making this your own

This is a personal config, shared as a starting point rather than something
meant to be used unmodified. If you fork it:

- `packages.sh` and the alias files reflect one person's tool choices — trim
  or swap what you don't want.
- `omarchy/stow/xdg-terminal` hardcodes WezTerm as the default terminal; drop
  that package (or point it elsewhere) if you'd rather keep an Omarchy
  default.
- `shell/stow/wezterm/.wezterm.lua` pins a specific font/theme — adjust to
  taste.
