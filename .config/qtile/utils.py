import iwlib


def get_wifi_icon(interface_name):
    level_1 = "󰤟 "
    level_2 = "󰤢 "
    level_3 = "󰤥 "
    level_4 = "󰤨 "
    no_signal = "󰤭 "
    interface = iwlib.get_iwconfig(interface_name)
    if "stats" not in interface:
        return no_signal
    quality = interface["stats"]["quality"]
    # essid = bytes(interface["ESSID"]).decode()
    if quality < 25:
        return level_1
    elif quality < 40:
        return level_2
    elif quality < 60:
        return level_3
    elif quality < 100:
        return level_4
