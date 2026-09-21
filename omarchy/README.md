# Omarchy layer

Machine-level config that only makes sense on an actual Omarchy install.
Stowed with `--target="$HOME"` just like the shell layer, but only run this
on a box that has Omarchy installed (`command -v omarchy`).

- `stow/hypr/.config/hypr/bindings.lua` — adds SUPER+SHIFT+CTRL+arrow to move
  the focused window to an adjacent monitor. Also repurposes SUPER+G, ALT+TAB,
  CTRL+TAB, SUPER+ALT+TAB, and SUPER+CTRL+TAB for tabbed window stacking (see
  `stow/hypr/.local/bin/omarchy-hyprland-group-workspace` below) — this
  replaces several Omarchy defaults, including CTRL+TAB, which apps no longer
  see.
- `stow/hypr/.local/bin/omarchy-hyprland-group-workspace` — SUPER+G groups
  every tiled window on the active workspace into one tabbed group, or
  ungroups if the focused window is already grouped.
- `stow/hypr/.config/hypr/input.lua` — natural (inverted) scrolling.
- `stow/xdg-terminal/.config/xdg-terminals.list` — makes WezTerm the default
  for `xdg-terminal-exec`, so SUPER+RETURN and anything else that shells out
  to `$TERMINAL` opens WezTerm instead of whatever Omarchy shipped. Not
  managed by `omarchy default terminal` (that command only knows about
  alacritty/foot/ghostty/kitty) — this repo just writes the file it would
  have written.
- `stow/screensaver/` — Omarchy's screensaver only launches in Alacritty, Foot,
  Ghostty or Kitty and bails out when the default terminal is anything else
  (WezTerm here). `.local/bin/omarchy-launch-screensaver-foot` is a copy of
  `omarchy-launch-screensaver` with Foot hardcoded, and
  `.config/omarchy/plugins/crowdersoup.idle` is a clone of `omarchy.idle` whose
  screensaver command calls it. `setup.sh` enables the clone and disables the
  stock plugin (that state lives in `shell.json`, which isn't stowed). Neither
  file follows upstream changes: if the screensaver breaks after `omarchy
  update`, diff them against `/usr/share/omarchy/bin/omarchy-launch-screensaver`
  and `/usr/share/omarchy/shell/plugins/services/idle/`. Requires `foot`.

These are Omarchy's user-override slots (see `omarchy menu keybindings
--print` and `/usr/share/omarchy/default/hypr/*.lua` for the full commented
template) — stowing over them replaces the file, not individual settings, so
merge in anything else you've added on the target machine before restowing.

## Deliberately left out (not portable / too machine-specific)

- `monitors.lua` — resolution and layout are per-display; copy it by hand if
  you want a starting point.
- Autostarting `maestral` in `autostart.lua` — only add this if the new
  machine also uses Maestral: `o.launch_on_start("maestral start")` /
  `o.launch_on_start("maestral_qt")`.
- `~/.config/omarchy/shell.json` bar tweaks (24h clock without the weekday,
  pinning an app to the tray) — small enough to just redo by hand via
  `omarchy bar` commands or a direct edit on each machine.
