# Qtile config file
# Customized by:
#  ____          _          ____
# |  _ \ ___  __| |_ __ ___/ ___|
# | |_) / _ \/ _` | '__/ _ \___ \
# |  __/  __/ (_| | | | (_) |__) |
# |_|   \___|\__,_|_|  \___/____/


class Theme:
    def __init__(self, name: str, colors: dict = None):
        self.name = name
        self.bg = colors["bg"]
        self.light_bg = colors["light-bg"]
        self.fg = colors["fg"]
        self.comment = colors["comment"]
        self.cyan = colors["cyan"]
        self.green = colors["green"]
        self.orange = colors["orange"]
        self.pink = colors["pink"]
        self.purple = colors["purple"]
        self.red = colors["red"]
        self.yellow = colors["yellow"]


dracula = Theme(
    "dracula",
    {
        "bg": "282a36",
        "light-bg": "44475a",
        "fg": "f8f8f2",
        "comment": "6272a4",
        "cyan": "8be9fd",
        "green": "50fa7b",
        "orange": "ffb86c",
        "pink": "ff79c6",
        "purple": "bd93f9",
        "red": "ff5555",
        "yellow": "f1fa8c",
    },
)

catppuccino = Theme(
    "catppuccino",
    {
        "bg": "232634",
        "light-bg": "626880",
        "fg": "c6d0f5",
        "comment": "85c1dc",
        "cyan": "8caaee",
        "green": "a6d189",
        "orange": "ef9f76",
        "pink": "eebebe",
        "purple": "ca9ee6",
        "red": "e78284",
        "yellow": "e5c890",
    },
)

onedark = Theme(
    "onedark",
    {
        "bg": "282c34",
        "light-bg": "444c56",
        "fg": "abb2bf",
        "comment": "5c6370",
        "cyan": "56b6c2",
        "green": "98c379",
        "orange": "d19a66",
        "pink": "c678dd",
        "purple": "c678dd",
        "red": "e06c75",
        "yellow": "e5c07b",
    },
)


available_themes = [dracula, catppuccino, onedark]


def get_theme(name: str) -> Theme:
    for theme in available_themes:
        if theme.name == name:
            return theme
    return dracula
