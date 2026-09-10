-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
hl.unbind("SUPER + W")
hl.unbind("SUPER + J")
hl.unbind("SUPER + X") -- was: Universal cut
hl.unbind("SUPER + K") -- was: Keybindings
hl.unbind("SUPER + L") -- was: Toggle workspace layout
hl.unbind("SUPER + SHIFT + S") -- was: Google Maps
hl.unbind("SUPER + SHIFT + A") -- was: ChatGPT (default)
hl.unbind("SUPER + SHIFT + B") -- was: Browser (default)
hl.unbind("SUPER + T") -- was: Toggle window floating/tiling
hl.unbind("SUPER + G") -- was: Toggle window grouping
hl.unbind("SUPER + O") -- was: Pop window out (float & pin)
hl.unbind("SUPER + SLASH") -- was: Monitor scaling up
hl.unbind("SUPER + C") -- was: Universal copy
hl.unbind("SUPER + SHIFT + G") -- was: Signal (default)
hl.unbind("SUPER + ALT + G") -- was: Move active window out of group

o.bind("SUPER + Q", "Close active Window", hl.dsp.window.close())
o.bind("SUPER + E", "File manager", "uwsm app -- nautilus --new-window")
o.bind("SUPER + X", "Toggle Split", hl.dsp.layout("togglesplit"))

o.bind("SUPER + SHIFT + S", "Screenshot of region", "omarchy-cmd-screenshot")

-- Applications
o.bind("SUPER + B", "Browser", "omarchy-launch-browser")
o.bind("SUPER + SHIFT + B", "Browser (private)", "omarchy-launch-browser --private")
o.bind("SUPER + M", "Music", "omarchy-launch-or-focus spotify")
o.bind("SUPER + N", "Editor", "omarchy-launch-editor")
o.bind("SUPER + T", "Activity", "omarchy-launch-tui btop")
o.bind("SUPER + D", "Docker", "omarchy-launch-tui lazydocker")
o.bind("SUPER + G", "Signal", 'omarchy-launch-or-focus signal "uwsm app -- signal-desktop"')
o.bind("SUPER + O", "Obsidian", 'omarchy-launch-or-focus obsidian "uwsm-app -- zennotes"')
o.bind("SUPER + SLASH", "Passwords", "uwsm app -- 1password")

-- Web apps
o.bind("SUPER + A", "ChatGPT", 'omarchy-launch-webapp "https://chatgpt.com"')
o.bind("SUPER + SHIFT + A", "Grok", 'omarchy-launch-webapp "https://grok.com"')
o.bind("SUPER + C", "Calendar", 'omarchy-launch-webapp "https://app.hey.com/calendar/weeks/"')
o.bind("SUPER + Y", "YouTube", 'omarchy-launch-webapp "https://youtube.com/"')
o.bind("SUPER + SHIFT + G", "WhatsApp", 'omarchy-launch-or-focus-webapp WhatsApp "https://web.whatsapp.com/"')
o.bind(
	"SUPER + ALT + G",
	"Google Messages",
	'omarchy-launch-or-focus-webapp "Google Messages" "https://messages.google.com/web/conversations"'
)

-- Move window focus with VIM/arrow keys
o.bind("SUPER + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))

-- Swap windows
o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

-- Resize active window with VIM keys
o.bind("ALT + H", "Resize window left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
o.bind("ALT + L", "Resize window right", hl.dsp.window.resize({ x = 10, y = 10, relative = true }))
o.bind("ALT + J", "Resize window down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))
o.bind("ALT + K", "Resize window up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))

o.bind("CTRL + SHIFT + F", "ZenNotes quick capture", "xdg-open zennotes://quick-capture")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")
