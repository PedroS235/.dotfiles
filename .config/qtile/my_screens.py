# Qtile config file
# Customized by:
#  ____          _          ____
# |  _ \ ___  __| |_ __ ___/ ___|
# | |_) / _ \/ _` | '__/ _ \___ \
# |  __/  __/ (_| | | | (_) |__) |
# |_|   \___|\__,_|_|  \___/____/


from libqtile.config import Screen
from libqtile import bar
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration
import my_colors
import my_options as opt

# import utils

theme = my_colors.get_theme(opt.THEME)

widget_decor = [
    BorderDecoration(colour=theme.cyan, border_width=[0, 0, 1, 0], padding_y=0)
]


def init_screens() -> list[Screen]:
    return [__primary_screen(), __secondary_screen()]


def __primary_screen() -> Screen:
    return Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    background=theme.bg,
                    foreground=theme.pink,
                    font="Font Awesome 5",
                    fontsize=20,
                    fmt="󰃮",
                    decorations=widget_decor,
                ),
                widget.Clock(
                    format="%a, %d %b %Y",
                    background=theme.bg,
                    foreground=theme.fg,
                    padding=5,
                    decorations=widget_decor,
                ),
                widget.TextBox(
                    background=theme.bg,
                    foreground=theme.pink,
                    font="Font Awesome 5",
                    fontsize=20,
                    fmt="| 󰥔",
                    decorations=widget_decor,
                ),
                widget.Clock(
                    format="%H:%M ",
                    background=theme.bg,
                    foreground=theme.fg,
                    padding=5,
                    decorations=widget_decor,
                ),
                widget.Prompt(),
                widget.Spacer(background=theme.bg),
                widget.GroupBox(
                    highlight_method="text",
                    background=theme.bg,
                    foreground=theme.fg,
                    block_highlight_text_color=theme.fg,
                    this_current_screen_border=theme.orange,
                    other_screen_border=theme.light_bg,
                    inactive=theme.light_bg,
                    active=theme.fg,
                    margin=5,
                    decorations=widget_decor,
                ),
                widget.Spacer(background=theme.bg),
                widget.Systray(
                    background=theme.bg,
                    decorations=widget_decor,
                ),
                widget.Sep(
                    background=theme.bg,
                    foreground=theme.bg,
                    linewidth=2,
                ),
                widget.TextBox(
                    background=theme.bg,
                    foreground=theme.pink,
                    font="Font Awesome 5",
                    fontsize=20,
                    fmt="",
                    decorations=widget_decor,
                ),
                widget.Memory(
                    format="{MemUsed:0.1f}{mm}\n{MemTotal:0.1f}{mm}",
                    background=theme.bg,
                    foreground=theme.fg,
                    measure_mem="G",
                    padding=5,
                    decorations=widget_decor,
                ),
                widget.Sep(
                    background=theme.bg,
                    foreground=theme.bg,
                    linewidth=2,
                ),
                widget.TextBox(
                    background=theme.bg,
                    foreground=theme.pink,
                    font="Font Awesome 5",
                    fontsize=20,
                    fmt=" ",
                    decorations=widget_decor,
                ),
                widget.ThermalSensor(
                    fmt="{}",
                    tag_sensor="Tctl",
                    background=theme.bg,
                    foreground=theme.fg,
                    foreground_alert=theme.red,
                    threshold=90,
                    padding=5,
                    decorations=widget_decor,
                ),
                widget.CPU(
                    format="{load_percent}%\n{freq_current}GHz",
                    background=theme.bg,
                    foreground=theme.fg,
                    padding=5,
                    decorations=widget_decor,
                ),
                widget.Sep(
                    background=theme.bg,
                    foreground=theme.bg,
                    linewidth=2,
                ),
                widget.NvidiaSensors(
                    fmt="GPU: {}",
                    tag_sensor="gpu",
                    foreground=theme.fg,
                    background=theme.bg,
                    foreground_alert=theme.red,
                    threshold=90,
                    padding=5,
                    decorations=widget_decor,
                ),
                widget.Sep(
                    background=theme.bg,
                    foreground=theme.bg,
                    linewidth=2,
                ),
                widget.Volume(
                    foreground=theme.pink,
                    fontsize=20,
                    background=theme.bg,
                    padding=5,
                    emoji=True,
                    emoji_list=["󰖁", "󰕿", "󰖀", "󰕾"],
                    decorations=widget_decor,
                ),
                widget.Volume(
                    fmt="{}",
                    foreground=theme.fg,
                    background=theme.bg,
                    padding=5,
                    decorations=widget_decor,
                ),
                widget.Sep(
                    background=theme.bg,
                    foreground=theme.bg,
                    linewidth=2,
                ),
                widget.TextBox(
                    background=theme.bg,
                    foreground=theme.fg,
                    fontsize=20,
                    # fmt=utils.get_wifi_icon("wlp2s0"),
                    fmt="wifi",
                    decorations=widget_decor,
                ),
                widget.Sep(
                    background=theme.bg,
                    foreground=theme.bg,
                    linewidth=2,
                ),
                widget.LaunchBar(
                    background=theme.bg,
                    foreground=theme.fg,
                    progs=[
                        (
                            "⏻ ",
                            "/home/pedros235/.config/qtile/scripts/powermenu.sh",
                        ),
                    ],
                    decorations=widget_decor,
                ),
            ],
            35,
        ),
        wallpaper=opt.WALLPAPER,
        wallpaper_mode="fill",
    )


def __secondary_screen() -> Screen:
    return Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    background=theme.bg,
                    foreground=theme.pink,
                    font="Font Awesome 5",
                    fontsize=20,
                    fmt="󰃮",
                    decorations=widget_decor,
                ),
                widget.Clock(
                    format="%a, %d %b %Y",
                    background=theme.bg,
                    foreground=theme.fg,
                    padding=5,
                    decorations=widget_decor,
                ),
                widget.TextBox(
                    background=theme.bg,
                    foreground=theme.pink,
                    font="Font Awesome 5",
                    fontsize=20,
                    fmt="| 󰥔",
                    decorations=widget_decor,
                ),
                widget.Clock(
                    format="%H:%M ",
                    background=theme.bg,
                    foreground=theme.fg,
                    padding=5,
                    decorations=widget_decor,
                ),
                widget.Spacer(background=theme.bg),
                widget.GroupBox(
                    highlight_method="text",
                    background=theme.bg,
                    foreground=theme.fg,
                    block_highlight_text_color=theme.fg,
                    this_current_screen_border=theme.orange,
                    other_screen_border=theme.light_bg,
                    inactive=theme.light_bg,
                    active=theme.fg,
                    margin=5,
                    decorations=widget_decor,
                ),
                widget.Spacer(background=theme.bg),
            ],
            35,
        ),
        wallpaper=opt.WALLPAPER,
        wallpaper_mode="fill",
    )
