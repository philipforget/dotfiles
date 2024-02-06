local wezterm = require 'wezterm'
config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.hide_tab_bar_if_only_one_tab = true
config.quit_when_all_windows_are_closed = false
config.audible_bell = "Disabled"

config.font_size = 14

config.front_end = "WebGpu"

config.keys = {
  {
    key = 'Enter',
    mods = 'CMD',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

config.window_decorations = "RESIZE"

function recompute_padding(window)
  local window_dims = window:get_dimensions()
  local overrides = window:get_config_overrides() or {}

  if window_dims.is_full_screen then
    overrides.window_padding = {
      top = 40,
    }
  end
  window:set_config_overrides(overrides)
end

wezterm.on('window-resized', function(window, pane)
  recompute_padding(window)
end)


return config
