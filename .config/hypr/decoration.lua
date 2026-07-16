hl.config({
    general = {
        -- Gaps & borders – light and uncluttered
        gaps_in = 4,
        gaps_out = 6,
        gaps_workspaces = 32,
        border_size = 1,
        no_focus_fallback = true,
        allow_tearing = true,
        snap = {
            enabled = true,
            window_gap = 4,
            monitor_gap = 6,
            respect_gaps = true,
        },
        col = {
            active_border = "rgba(0DB7D4FF)",
            inactive_border = "rgba(31313633)",
        },
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
        smart_split = false,
        smart_resizing = false,
    },
})

hl.config({
    decoration = {
        rounding = 10,
        shadow = {
            enabled = true,
            range = 16,
            render_power = 2,
            color = "rgba(00000040)",
        },
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            vibrancy = 0.14,
        },
    },
})

hl.config({
    animations = {
        enabled = true,
    },
})
