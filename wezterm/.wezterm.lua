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
-- config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = "Ir Black (base16)"
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
	-- "Apple Color Emoji",
	"RecursiveMnCslSt Nerd Font",
	"LXGW WenKai Mono",
	"98WB-1",
})

config.font_size = 18.0
config.line_height = 1.0

-- Spawn a zsh loginshell in login mode
config.default_prog = { '/usr/bin/fish', '-l' }

-- kitty protocol
config.enable_kitty_keyboard = true
enable_csi_u_key_encoding = true

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
		key = "Enter",
		mods = "CTRL",
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

	-- -- FIXME: Or maybe it's not fixable?
	{
		key = "i",
		mods = "CTRL",
		action = wezterm.action.SendKey({
			key = "i",
			mods = "CTRL",
		}),
	},
}

-- and finally, return the configuration to wezterm
return config
