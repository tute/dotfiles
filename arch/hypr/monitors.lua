-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

hl.env("GDK_SCALE", "2")
hl.monitor({ output = "", mode = "5120x2880@60", position = "auto", scale = "auto" })
