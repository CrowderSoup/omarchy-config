local wezterm = require("wezterm")
local act = wezterm.action

-- NOTE: WezTerm isn't wired into Omarchy's theme switcher (only
-- alacritty/foot/ghostty/kitty get repainted by `omarchy theme set`), so
-- this color scheme stays static until it's changed here by hand.

return {
	window_decorations = "RESIZE",
	default_cwd = wezterm.home_dir,
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 13,
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
