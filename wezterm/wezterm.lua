--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local b = require("utils/background")
local cs = require("utils/color_scheme")
local f = require("utils/font")
local h = require("utils/helpers")
local k = require("utils/keys")
-- local w = require("utils/wallpaper")

local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if package.config:sub(1, 1) == '\\' then
	-- config.default_prog = { "pwsh", "-NoExit", "-Command", "~/.config/powershell/jay-neo/jay-neo.ps1" }
	config.default_prog = { "pwsh", "-nolog"}
else 
	config.default_prog = { "bash" }
end

config.adjust_window_size_when_changing_font_size = false
config.debug_key_events = false
config.enable_tab_bar = false
config.native_macos_fullscreen_mode = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 12,
	right = 12,
	top = '0.6cell',
	bottom = 0,
}
config.font = f.get_font({
	"Hack NF",
	-- "Monaspace Argon",
	-- "Monaspace Krypton",
	-- "Monaspace Neon",
	-- "Monaspace Radon",
	-- "Monaspace Xenon",
})
-- config.color_scheme = "Black"
config.default_cursor_style = 'BlinkingBar' -- SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, BlinkingBar
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.window_background_opacity = 0.92

-- config = {
-- 	background = {
-- 		-- w.get_wallpaper(),
-- 		b.get_background(),
-- 	},

-- 	font_size = 10,
-- 	line_height = 1.1,


-- 	-- color_scheme = cs.get_color_scheme(),

-- 	set_environment_variables = {
-- 		-- THEME_FLAVOUR = "latte",
-- 		BAT_THEME = h.is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
-- 		TERM = "xterm-256color",
-- 		LC_ALL = "en_US.UTF-8",
-- 	},

-- 	-- general options
-- }


-- 	-- keys
-- config.keys = {
-- 		k.cmd_key(".", k.multiple_actions(":ZenMode")),
-- 		k.cmd_key("[", act.SendKey({ mods = "CTRL", key = "o" })),
-- 		k.cmd_key("]", act.SendKey({ mods = "CTRL", key = "i" })),
-- 		k.cmd_key("f", k.multiple_actions(":Grep")),
-- 		-- k.cmd_key("H", act.SendKey({ mods = "CTRL", key = "h" })),
-- 		k.cmd_key("i", k.multiple_actions(":SmartGoTo")),
-- 		-- k.cmd_key("J", act.SendKey({ mods = "CTRL", key = "j" })),
-- 		-- k.cmd_key("K", act.SendKey({ mods = "CTRL", key = "k" })),
-- 		-- k.cmd_key("K", act.SendKey({ mods = "CTRL", key = "k" })),
-- 		-- k.cmd_key("L", act.SendKey({ mods = "CTRL", key = "l" })),
-- 		k.cmd_key("P", k.multiple_actions(":GoToCommand")),
-- 		k.cmd_key("p", k.multiple_actions(":GoToFile")),
-- 		k.cmd_key("j", k.multiple_actions(":GoToFile")),
-- 		k.cmd_key("q", k.multiple_actions(":qa!")),
-- 		k.cmd_to_tmux_prefix("1", "1"),
-- 		k.cmd_to_tmux_prefix("2", "2"),
-- 		k.cmd_to_tmux_prefix("3", "3"),
-- 		k.cmd_to_tmux_prefix("4", "4"),
-- 		k.cmd_to_tmux_prefix("5", "5"),
-- 		k.cmd_to_tmux_prefix("6", "6"),
-- 		k.cmd_to_tmux_prefix("7", "7"),
-- 		k.cmd_to_tmux_prefix("8", "8"),
-- 		k.cmd_to_tmux_prefix("9", "9"),
-- 		k.cmd_to_tmux_prefix("`", "n"),
-- 		k.cmd_to_tmux_prefix("b", "B"),
-- 		k.cmd_to_tmux_prefix("C", "C"),
-- 		k.cmd_to_tmux_prefix("d", "D"),
-- 		k.cmd_to_tmux_prefix("G", "G"),
-- 		k.cmd_to_tmux_prefix("g", "g"),
-- 		k.cmd_to_tmux_prefix("K", "T"),
-- 		k.cmd_to_tmux_prefix("k", "K"),
-- 		k.cmd_to_tmux_prefix("l", "L"),
-- 		k.cmd_to_tmux_prefix("n", '"'),
-- 		k.cmd_to_tmux_prefix("N", "%"),
-- 		k.cmd_to_tmux_prefix("o", "u"),
-- 		k.cmd_to_tmux_prefix("T", "!"),
-- 		k.cmd_to_tmux_prefix("t", "c"),
-- 		k.cmd_to_tmux_prefix("w", "x"),
-- 		k.cmd_to_tmux_prefix("z", "z"),
-- 		k.cmd_to_tmux_prefix("Z", "Z"),

-- 		k.cmd_key(
-- 			"R",
-- 			act.Multiple({
-- 				act.SendKey({ key = "\x1b" }), -- escape
-- 				k.multiple_actions(":source %"),
-- 			})
-- 		),

-- 		k.cmd_key(
-- 			"s",
-- 			act.Multiple({
-- 				act.SendKey({ key = "\x1b" }), -- escape
-- 				k.multiple_actions(":w"),
-- 			})
-- 		),

-- 		{
-- 			mods = "CMD|SHIFT",
-- 			key = "}",
-- 			action = act.Multiple({
-- 				act.SendKey({ mods = "CTRL", key = "b" }),
-- 				act.SendKey({ key = "n" }),
-- 			}),
-- 		},
-- 		{
-- 			mods = "CMD|SHIFT",
-- 			key = "{",
-- 			action = act.Multiple({
-- 				act.SendKey({ mods = "CTRL", key = "b" }),
-- 				act.SendKey({ key = "p" }),
-- 			}),
-- 		},

-- 		{
-- 			mods = "CTRL",
-- 			key = "Tab",
-- 			action = act.Multiple({
-- 				act.SendKey({ mods = "CTRL", key = "b" }),
-- 				act.SendKey({ key = "n" }),
-- 			}),
-- 		},

-- 		{
-- 			mods = "CTRL|SHIFT",
-- 			key = "Tab",
-- 			action = act.Multiple({
-- 				act.SendKey({ mods = "CTRL", key = "b" }),
-- 				act.SendKey({ key = "n" }),
-- 			}),
-- 		},

-- 		-- FIX: disable binding
-- 		-- {
-- 		-- 	mods = "CMD",
-- 		-- 	key = "`",
-- 		-- 	action = act.Multiple({
-- 		-- 		act.SendKey({ mods = "CTRL", key = "b" }),
-- 		-- 		act.SendKey({ key = "n" }),
-- 		-- 	}),
-- 		-- },

-- 		{
-- 			mods = "CMD",
-- 			key = "~",
-- 			action = act.Multiple({
-- 				act.SendKey({ mods = "CTRL", key = "b" }),
-- 				act.SendKey({ key = "p" }),
-- 			}),
-- 		},
-- }

config.leader = { key = "phys:Space", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	-- Send C-a when pressing C-a twice
	{ key = "phys:Space",          mods = "LEADER|CTRL", action = act.SendKey { key = "phys:Space", mods = "CTRL" } },
	{ key = "c",          mods = "LEADER",      action = act.ActivateCopyMode },
	{ key = "p", mods = "LEADER",      action = act.ActivateCommandPalette },
  
	-- Pane keybindings
	{ key = "s",          mods = "LEADER",      action = act.SplitVertical { domain = "CurrentPaneDomain" } },
	{ key = "v",          mods = "LEADER",      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
	{ key = "h",          mods = "LEADER",      action = act.ActivatePaneDirection("Left") },
	{ key = "j",          mods = "LEADER",      action = act.ActivatePaneDirection("Down") },
	{ key = "k",          mods = "LEADER",      action = act.ActivatePaneDirection("Up") },
	{ key = "l",          mods = "LEADER",      action = act.ActivatePaneDirection("Right") },
	{ key = "q",          mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
	{ key = "z",          mods = "LEADER",      action = act.TogglePaneZoomState },
	{ key = "o",          mods = "LEADER",      action = act.RotatePanes "Clockwise" },
	
	-- We can make separate keybindings for resizing panes
	-- But Wezterm offers custom "mode" in the name of "KeyTable"
	{ key = "r",          mods = "LEADER",      action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },
  
	-- Tab keybindings
	{ key = "t",          mods = "LEADER",      action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "[",          mods = "LEADER",      action = act.ActivateTabRelative(-1) },
	{ key = "]",          mods = "LEADER",      action = act.ActivateTabRelative(1) },
	{ key = "n",          mods = "LEADER",      action = act.ShowTabNavigator },
	{
	  key = "e",
	  mods = "LEADER",
	  action = act.PromptInputLine {
		description = wezterm.format {
		  { Attribute = { Intensity = "Bold" } },
		  { Foreground = { AnsiColor = "Fuchsia" } },
		  { Text = "Renaming Tab Title...:" },
		},
		action = wezterm.action_callback(function(window, pane, line)
		  if line then
			window:active_tab():set_title(line)
		  end
		end)
	  }
	},
	-- Key table for moving tabs around
	{ key = "m", mods = "LEADER",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
	-- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
	{ key = "{", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },
  
	-- Lastly, workspace
	{ key = "w", mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
  
}

config.key_tables = {
	resize_pane = {
	  { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
	  { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
	  { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
	  { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
	  { key = "Escape", action = "PopKeyTable" },
	  { key = "Enter",  action = "PopKeyTable" },
	},
	move_tab = {
	  { key = "h",      action = act.MoveTabRelative(-1) },
	  { key = "j",      action = act.MoveTabRelative(-1) },
	  { key = "k",      action = act.MoveTabRelative(1) },
	  { key = "l",      action = act.MoveTabRelative(1) },
	  { key = "Escape", action = "PopKeyTable" },
	  { key = "Enter",  action = "PopKeyTable" },
	}
}
























wezterm.on("user-var-changed", function(window, pane, name, value)
	-- local appearance = window:get_appearance()
	-- local is_dark = appearance:find("Dark")
	local overrides = window:get_config_overrides() or {}
	wezterm.log_info("name", name)
	wezterm.log_info("value", value)

	if name == "T_SESSION" then
		local session = value
		wezterm.log_info("is session", session)
		overrides.background = {
			w.set_tmux_session_wallpaper(value),
			{
				source = {
					Gradient = {
						colors = { "#000000" },
					},
				},
				width = "100%",
				height = "100%",
				opacity = 0.95,
			},
		}
	end

	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
		else
			overrides.font_size = number_value
		end
	end
	if name == "DIFF_VIEW" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.DecreaseFontSize, pane)
				number_value = number_value - 1
			end
			-- overrides.background = {
			-- 	w.set_nvim_wallpaper("Diffview.jpeg"),
			--
			-- 	{
			-- 		source = {
			-- 			Gradient = {
			-- 				colors = { "#000000" },
			-- 			},
			-- 		},
			-- 		width = "100%",
			-- 		height = "100%",
			-- 		opacity = 0.95,
			-- 	},
			-- }
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.background = nil
			overrides.font_size = nil
		else
			overrides.font_size = number_value
		end
	end
	window:set_config_overrides(overrides)
end)

return config
