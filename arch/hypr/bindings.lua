-- renCal instead of HEY Calendar
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Calendar", { launch = "rencal" })

-- Slack instead of Google Maps
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Slack", { launch = "slack" })

-- Tidal instead of Spotify
hl.unbind("SUPER + SHIFT + M")
o.bind("SUPER + SHIFT + M", "Tidal", { webapp = "https://tidal.com/" })

o.bind("SUPER + SHIFT + PERIOD", "1Password", { omarchy = "1password" })

-- Vim-style focus movement
o.bind("SUPER + SHIFT + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Focus right", hl.dsp.focus({ direction = "r" }))

o.bind("CTRL + ALT + K", nil, "hyprctl switchxkblayout all next")
