# Qtile config file
# Customized by:
#  ____          _          ____
# |  _ \ ___  __| |_ __ ___/ ___|
# | |_) / _ \/ _` | '__/ _ \___ \
# |  __/  __/ (_| | | | (_) |__) |
# |_|   \___|\__,_|_|  \___/____/


from libqtile.config import Key
from libqtile.lazy import lazy
import my_options as opt


def init_keymaps() -> list[Key]:
    keys = []
    keys.extend(init_mouvement_keympas())
    keys.extend(init_resize_keymaps())
    keys.extend(init_layout_keymaps())
    keys.extend(init_window_keymaps())
    keys.extend(init_app_keymaps())
    keys.extend(init_media_keymaps())
    keys.extend(init_screenshot_keymaps())
    return keys


def init_mouvement_keympas() -> list[Key]:
    return [
        # Switch between windows
        Key([opt.SUPER], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([opt.SUPER], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([opt.SUPER], "j", lazy.layout.down(), desc="Move focus down"),
        Key([opt.SUPER], "k", lazy.layout.up(), desc="Move focus up"),
        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key(
            [opt.SUPER, "shift"],
            "h",
            lazy.layout.shuffle_left(),
            desc="Move window to the left",
        ),
        Key(
            [opt.SUPER, "shift"],
            "l",
            lazy.layout.shuffle_right(),
            desc="Move window to the right",
        ),
        Key(
            [opt.SUPER, "shift"],
            "j",
            lazy.layout.shuffle_down(),
            desc="Move window down",
        ),
        Key(
            [opt.SUPER, "shift"],
            "k",
            lazy.layout.shuffle_up(),
            desc="Move window up",
        ),
    ]


def init_resize_keymaps() -> list[Key]:
    return [
        # Grow windows. If current window is on the edge of screen and direction
        # will be to screen edge - window would shrink.
        Key(
            [opt.SUPER, "control"],
            "h",
            lazy.layout.grow_left(),
            desc="Grow window to the left",
        ),
        Key(
            [opt.SUPER, "control"],
            "l",
            lazy.layout.grow_right(),
            desc="Grow window to the right",
        ),
        Key(
            [opt.SUPER, "control"],
            "j",
            lazy.layout.grow_down(),
            desc="Grow window down",
        ),
        Key(
            [opt.SUPER, "control"],
            "k",
            lazy.layout.grow_up(),
            desc="Grow window up",
        ),
        Key(
            [opt.SUPER],
            "n",
            lazy.layout.normalize(),
            desc="Reset all window sizes",
        ),
    ]


def init_layout_keymaps() -> list[Key]:
    return [
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key(
            [opt.SUPER, "shift"],
            "Return",
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack",
        ),
    ]


def init_window_keymaps() -> list[Key]:
    return [
        Key(
            [opt.SUPER, "shift"],
            "r",
            lazy.restart(),
            desc="Restart qtile",
        ),
        Key(
            [opt.SUPER, "shift"],
            "q",
            lazy.shutdown(),
            desc="Shutdown qtile",
        ),
        Key([opt.SUPER], "w", lazy.window.kill(), desc="Kill focused window"),
        Key(
            [opt.SUPER],
            "f",
            lazy.window.toggle_fullscreen(),
            desc="Toggle fullscreen on the focused window",
        ),
        Key(
            [opt.SUPER],
            "t",
            lazy.window.toggle_floating(),
            desc="Toggle floating on the focused window",
        ),
    ]


def init_media_keymaps() -> list[Key]:
    return [
        Key(
            [],
            "XF86AudioLowerVolume",
            lazy.spawn("amixer -D pulse set Master 5%-"),
            desc="Lower Volume by 5%",
        ),
        Key(
            [],
            "XF86AudioRaiseVolume",
            lazy.spawn("amixer -D pulse set Master 5%+"),
            desc="Raise Volume by 5%",
        ),
        Key(
            [],
            "XF86AudioMute",
            lazy.spawn("amixer -D pulse set Master 1+ toggle"),
            desc="Mute/Unmute Volume",
        ),
        Key(
            [],
            "XF86AudioPlay",
            lazy.spawn("playerctl play-pause"),
            desc="Play/Pause player",
        ),
        Key(
            [],
            "XF86AudioNext",
            lazy.spawn("playerctl next"),
            desc="Skip to next",
        ),
        Key(
            [],
            "XF86AudioPrev",
            lazy.spawn("playerctl previous"),
            desc="Skip to previous",
        ),
        Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s 5%+")),
        Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%-")),
    ]


def init_screenshot_keymaps() -> list[Key]:
    return [
        Key(
            ["control", "shift"],
            "s",
            lazy.spawn(
                "scrot '/tmp/screenshot_%Y-%m-%d-%H:%M.png' -s -e 'xclip -selection clipboard -t image/png -i $f'"
            ),
            desc="Take a screenshot of a selected area",
        ),
        # Key(
        #     [opt.SUPER, "control", "shift"],
        #     "s",
        #     lazy.spawncmd("scrot -u ~/Pictures/Screenshots/screenshot"),
        #     desc="Take a screenshot of the current window",
        # ),
    ]


def init_app_keymaps() -> list[Key]:
    return [
        Key(
            [opt.SUPER],
            "Return",
            lazy.spawn(opt.TERM),
            desc="Launch terminal",
        ),
        Key(
            [opt.SUPER],
            "space",
            lazy.spawn("rofi -show drun"),
            desc="Launch rofi as application launcher",
        ),
        Key(
            [opt.SUPER],
            "r",
            lazy.spawn("rofi -show run"),
            desc="Launch rofi as a command launcher",
        ),
        Key(
            [opt.SUPER, "control"],
            "e",
            lazy.spawn("rofi -show emoji"),
            desc="Launch an emoji picker",
        ),
        Key(
            [opt.SUPER, "control"],
            "q",
            lazy.spawn("/home/pedros235/.config/qtile/scripts/powermenu.sh"),
            desc="Launch an emoji picker",
        ),
        Key(
            [opt.SUPER],
            "b",
            lazy.spawn(opt.BROWSER),
            desc="Launch firefox",
        ),
        Key(
            [opt.SUPER],
            "e",
            lazy.spawn(opt.FILE_MANAGER),
            desc="Launch file manager",
        ),
        Key(
            [opt.SUPER],
            "m",
            lazy.spawn(opt.MAIL),
            desc="Launch mailspring",
        ),
    ]
