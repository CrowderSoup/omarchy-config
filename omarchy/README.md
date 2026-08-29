# Omarchy layer

Machine-level config that only makes sense on an actual Omarchy install.
Stowed with `--target="$HOME"` just like the shell layer, but only run this
on a box that has Omarchy installed (`command -v omarchy`).

- `stow/hypr/.config/hypr/bindings.lua` — adds SUPER+SHIFT+CTRL+arrow to move
  the focused window to an adjacent monitor.
- `stow/hypr/.config/hypr/input.lua` — natural (inverted) scrolling.
- `stow/xdg-terminal/.config/xdg-terminals.list` — makes WezTerm the default
  for `xdg-terminal-exec`, so SUPER+RETURN and anything else that shells out
  to `$TERMINAL` opens WezTerm instead of whatever Omarchy shipped. Not
  managed by `omarchy default terminal` (that command only knows about
  alacritty/foot/ghostty/kitty) — this repo just writes the file it would
  have written.

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
