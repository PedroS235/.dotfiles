-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

-- Lenovo T14 Gen-4 (Laptop Monitor)
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.25 })

-- MSI Oled 32" (Desktop Monitor)
-- hl.env("GDK_SCALE", "1.75")
hl.monitor({ output = "desc:Microstep MAG321UX OLED", mode = "highres", position = "auto", scale = 1.25 })
