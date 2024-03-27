local wezterm = require("wezterm")
config = wezterm.config_builder()

config.color_scheme = "Catppuccin Latte"
config.hide_tab_bar_if_only_one_tab = true
config.quit_when_all_windows_are_closed = false
config.audible_bell = "Disabled"

config.font_size = 14

config.front_end = "WebGpu"

config.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
}

config.window_padding = {
	left = 40,
	right = 40,
	top = 40,
	bottom = 40,
}

config.window_decorations = "RESIZE"

function recompute_padding(window)
	local window_dims = window:get_dimensions()
	local overrides = window:get_config_overrides() or {}

	if window_dims.is_full_screen then
		overrides.window_padding = {
			top = 70,
		}
	end
	window:set_config_overrides(overrides)
end

wezterm.on("window-resized", function(window, pane)
	recompute_padding(window)
end)

function scheme_for_appearance(appearance)
	return "Catppuccin Mocha"
	-- if appearance:find("Dark") then
	--   return "Catppuccin Mocha"
	-- else
	--   return "Catppuccin Latte"
	-- end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

return config
