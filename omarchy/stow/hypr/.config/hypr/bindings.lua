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

-- Tabbed window stacking.
-- SUPER+G was "Toggle window grouping" (grouped only the focused window).
-- Now it groups every tiled window on the current workspace into one tabbed stack.
hl.unbind("SUPER + G")
o.bind("SUPER + G", "Group all windows on workspace", "omarchy-hyprland-group-workspace")

-- ALT+TAB was "Focus on next window" / "Reveal active window on top" (the
-- app switcher). ALT+SHIFT+TAB still does "Focus on previous window" and is
-- left alone. CTRL+TAB was unbound, but note it's commonly used inside apps
-- (browsers, terminals, editors) for their own tab switching -- binding it
-- here at the compositor level means those apps will no longer see it.
hl.unbind("ALT + TAB")
o.bind("ALT + TAB", "Next tab in group", hl.dsp.group.next())
o.bind("CTRL + TAB", "Previous tab in group", hl.dsp.group.prev())

-- Reorder the focused window's position within its own tab group.
-- SUPER+ALT+TAB was "Next window in group" (a cycle, same as our new plain
-- ALT+TAB), so it's free to repurpose. SUPER+CTRL+TAB was "Former workspace"
-- (jump back to whichever workspace you were on before) -- you're giving
-- that up on this combo.
hl.unbind("SUPER + ALT + TAB")
hl.unbind("SUPER + CTRL + TAB")
o.bind("SUPER + ALT + TAB", "Move window forward in group", hl.dsp.window.swap({ next = true }))
o.bind("SUPER + CTRL + TAB", "Move window backward in group", hl.dsp.window.swap({ prev = true }))
