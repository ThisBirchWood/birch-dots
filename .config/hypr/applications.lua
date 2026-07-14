-- Opacity
hl.window_rule({
    name  = "opacity_0_75_0_6",
    match = {
	class = ".*" .. terminal .. ".*"
    },
    opacity = "0.75 0.6",
})

-- Workspace
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
