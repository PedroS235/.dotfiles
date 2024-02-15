# Qtile config file
# Customized by:
#  ____          _          ____
# |  _ \ ___  __| |_ __ ___/ ___|
# | |_) / _ \/ _` | '__/ _ \___ \
# |  __/  __/ (_| | | | (_) |__) |
# |_|   \___|\__,_|_|  \___/____/


from libqtile.config import Group, Key
from libqtile.lazy import lazy
import my_options as opt


def init_groups(keys: list[Key]) -> list[Group]:
    groups = []
    # Development Group
    groups.append(Group("1", label="1", spawn=opt.TERM))
    # Browser Group
    groups.append(Group("2", label="2", spawn=opt.BROWSER))
    # Chat Group
    groups.append(Group("3", label="3", spawn=opt.CHAT))
    # Music Group
    groups.append(Group("4", label="4", spawn=opt.MUSIC))
    # File Manager Group
    groups.append(Group("5", label="5", spawn=opt.MAIL))
    groups.append(Group("6", label="6"))
    groups.append(Group("7", label="7"))
    groups.append(Group("8", label="8"))
    groups.append(Group("9", label="9"))

    __init_group_keybinds(groups, keys)

    return groups


def __init_group_keybinds(groups: list[Group], keys: list[Key]) -> list[Key]:
    for i in groups:
        keys.extend(
            [
                # mod1 + letter of group = switch to group
                Key(
                    [opt.SUPER],
                    i.name,
                    lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name),
                ),
                # mod1 + shift + letter of group = switch to & move focused
                # window to group
                Key(
                    [opt.SUPER, "shift"],
                    i.name,
                    lazy.window.togroup(i.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(
                        i.name
                    ),
                ),
            ]
        )
