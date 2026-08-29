local wezterm = require("wezterm")
local act = wezterm.action

-- NOTE: WezTerm isn't wired into Omarchy's theme switcher (only
-- alacritty/foot/ghostty/kitty get repainted by `omarchy theme set`), so
-- this color scheme stays static until it's changed here by hand.

return {
	-- Hyprland handles move (SUPER + drag) and resize (SUPER + right-drag)
	-- itself, so there's no need for wezterm's own drag/resize edge.
	window_decorations = "NONE",
	hide_tab_bar_if_only_one_tab = true,
	default_cwd = wezterm.home_dir,
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 10,
	color_scheme = "Tokyo Night",
	keys = {
		{
			key = "t",
			mods = "SHIFT|ALT",
			action = act.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
			}),
		},
	},
}
