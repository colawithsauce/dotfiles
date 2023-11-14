-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Tokyo Night (Gogh)"
config.color_scheme = "Dark+"

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Wayland support
config.enable_wayland = true

-- Font
config.font = wezterm.font_with_fallback({
	"Recursive Mono Linear Static",
	"SFMono Nerd Font Mono",
	"LXGW WenKai Mono",
})

config.font_size = 20.0

-- Key
config.keys = {
	-- Turn off the default ALT-Enter Hide action, allowing ALT-Enter to
	-- be potentially recognized and handled by the tab
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},

	{
		key = "i",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},

	{
		key = " ",
		mods = "SHIFT",
		action = wezterm.action.SendKey({
			key = " ",
		}),
	},
}

-- and finally, return the configuration to wezterm
return config
