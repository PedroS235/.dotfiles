# Qtile config file
# Customized by:
#  ____          _          ____
# |  _ \ ___  __| |_ __ ___/ ___|
# | |_) / _ \/ _` | '__/ _ \___ \
# |  __/  __/ (_| | | | (_) |__) |
# |_|   \___|\__,_|_|  \___/____/


from libqtile import layout
from libqtile.lazy import lazy
from libqtile.config import Drag, Click, Match
import my_colors
import my_options as opt

theme = my_colors.get_theme(opt.THEME)

border_focus = theme.cyan
border_normal = theme.fg
border_width = 2
border_margin = 5


def init_layouts() -> list:
    return [
        layout.MonadTall(
            border_width=border_width,
            border_focus=border_focus,
            border_normal=border_normal,
            margin=border_margin,
        ),
        layout.Bsp(
            border_width=border_width,
            border_focus=border_focus,
            border_normal=border_normal,
            margin=border_margin,
        ),
        layout.Columns(
            border_width=border_width,
            border_focus=border_focus,
            border_normal=border_normal,
            margin=border_margin,
        ),
        # layout.Max(),
        # layout.Stack(num_stacks=2),
        # layout.Matrix(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
    ]


def init_mouse_floating_layout() -> list:
    return [
        Drag(
            [opt.SUPER],
            "Button1",
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        Drag(
            [opt.SUPER],
            "Button3",
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
        Click([opt.SUPER], "Button2", lazy.window.bring_to_front()),
    ]


def init_floating_layout() -> layout.Floating:
    return layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,
            Match(wm_class="confirmreset"),  # gitk
            Match(wm_class="makebranch"),  # gitk
            Match(wm_class="maketag"),  # gitk
            Match(wm_class="ssh-askpass"),  # ssh-askpass
            Match(title="branchdialog"),  # gitk
            Match(title="pinentry"),  # GPG key password entry
        ],
        border_focus=theme.green,
        border_normal=theme.light_bg,
    )
