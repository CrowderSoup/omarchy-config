-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- Move the focused window to the monitor in a direction (distinct from the
-- default SUPER+SHIFT+arrow "swap window" and SUPER+SHIFT+ALT+arrow "move
-- workspace to monitor" bindings).
o.bind("SUPER + SHIFT + CTRL + LEFT", "Move window to left monitor", hl.dsp.window.move({ direction = "left" }))
o.bind("SUPER + SHIFT + CTRL + RIGHT", "Move window to right monitor", hl.dsp.window.move({ direction = "right" }))
o.bind("SUPER + SHIFT + CTRL + UP", "Move window to up monitor", hl.dsp.window.move({ direction = "up" }))
o.bind("SUPER + SHIFT + CTRL + DOWN", "Move window to down monitor", hl.dsp.window.move({ direction = "down" }))
