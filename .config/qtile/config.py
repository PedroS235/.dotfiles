# Qtile config file
# Customized by:
#  ____          _          ____
# |  _ \ ___  __| |_ __ ___/ ___|
# | |_) / _ \/ _` | '__/ _ \___ \
# |  __/  __/ (_| | | | (_) |__) |
# |_|   \___|\__,_|_|  \___/____/

import subprocess
import os
from libqtile import hook
import my_keymaps
import my_groups
import my_screens
import my_layouts
import my_options as opt

# Window Manager Visible Name
wmname = opt.WM_NAME

keys = my_keymaps.init_keymaps()

groups = my_groups.init_groups(keys)

screens = my_screens.init_screens()

widget_defaults = opt.WIDGET_DEFAULTS
extension_defaults = widget_defaults.copy()

layouts = my_layouts.init_layouts()
mouse = my_layouts.init_mouse_floating_layout()
floating_layout = my_layouts.init_floating_layout()

# Drag Floating Rules
dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/scripts/autostart.sh")
    subprocess.Popen([home])
