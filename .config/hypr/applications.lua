-- Opacity
hl.window_rule({
    name  = "opacity_0_75_0_6",
    match = {
	class = ".*" .. terminal .. ".*"
    },
    opacity = "0.75 0.6",
})

-- Workspaces
hl.window_rule({
    workspace = "1",
    match = {
	class = ".*[Mm]inecraft.*"
    }
})

hl.window_rule({
    workspace = "1",
    match = {
	class = ".*[Ss]team*."
    }
})

hl.window_rule({
    name  = "shrink-file-picker",
    match = { class = "^(xdg-desktop-portal-gtk)$" },
    float = true,
    size  = {900, 900},
    move  = {"(monitor_w - window_w) / 2", "(monitor_h - window_h) / 2"},
})
