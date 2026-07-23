---@module 'hl'

local mainMod = "SUPER"

-- Sets "Windows" key as main modifier
hl.bind(mainMod .. " + " .. "RETURN", hl.dsp.exec_cmd(terminal), { description = "Terminal" })

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + " .. "up", hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind(mainMod .. " + " .. "down", hl.dsp.focus({ direction = "down" }), { description = "Focus down" })

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }), { description = "Workspace 1" })
hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }), { description = "Workspace 2" })
hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }), { description = "Workspace 3" })
hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }), { description = "Workspace 4" })
hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }), { description = "Workspace 5" })
hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = 6 }), { description = "Workspace 6" })
hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = 7 }), { description = "Workspace 7" })
hl.bind(mainMod .. " + " .. 8, hl.dsp.focus({ workspace = 8 }), { description = "Workspace 8" })
hl.bind(mainMod .. " + " .. 9, hl.dsp.focus({ workspace = 9 }), { description = "Workspace 9" })
hl.bind(mainMod .. " + " .. 0, hl.dsp.focus({ workspace = 10 }), { description = "Workspace 10" })

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }), { description = "Move window to workspace 1" })
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }), { description = "Move window to workspace 2" })
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }), { description = "Move window to workspace 3" })
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }), { description = "Move window to workspace 4" })
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }), { description = "Move window to workspace 5" })
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }), { description = "Move window to workspace 6" })
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }), { description = "Move window to workspace 7" })
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 8, hl.dsp.window.move({ workspace = 8 }), { description = "Move window to workspace 8" })
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 9, hl.dsp.window.move({ workspace = 9 }), { description = "Move window to workspace 9" })
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 0, hl.dsp.window.move({ workspace = 10 }), { description = "Move window to workspace 10" })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + " .. "right", hl.dsp.focus({ workspace = "+1" }), { description = "Next workspace" })
hl.bind(mainMod .. " + " .. "left", hl.dsp.focus({ workspace = "-1" }), { description = "Previous workspace" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- Change wallpaper
hl.bind(mainMod .. " + " .. "W", hl.dsp.exec_cmd("~/.config/wofi/scripts/wallpaper.sh"), { description = "Change wallpaper" })
hl.bind(mainMod .. " + " .. "L", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, description = "Brightness up" })
hl.bind(mainMod .. " + " .. "K", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, description = "Brightness down" })

-- Volume
hl.bind("F7", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, description = "Volume down" })
hl.bind("F8", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, description = "Volume up" })
hl.bind("F9", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, description = "Mute output" })
hl.bind("F10", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, description = "Mute microphone" })

-- Playback (requires playerctl)
hl.bind("F4", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Previous track" })
hl.bind("F5", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play/pause" })
hl.bind("F6", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = "Next track" })

hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms off"), { locked = true, description = "Displays off on lid close" })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms on"), { locked = true, description = "Displays on on lid open" })

-- My binds
hl.bind("SUPER + CTRL" .. " + " .. "left", hl.dsp.window.swap({ direction = "left" }), { description = "Swap window left" })
hl.bind("SUPER + CTRL" .. " + " .. "right", hl.dsp.window.swap({ direction = "right" }), { description = "Swap window right" })
hl.bind("SUPER + SHIFT" .. " + " .. "F", hl.dsp.window.fullscreen(), { description = "Fullscreen" })
hl.bind("SUPER + CTRL" .. " + " .. "F", hl.dsp.window.fullscreen({mode = "maximized"}), { description = "Maximize" })
hl.bind("SUPER" .. " + " .. "Q", hl.dsp.window.close(), { description = "Close window" })
hl.bind("ALT" .. " + " .. "TAB", hl.dsp.window.cycle_next(), { description = "Cycle windows" })
hl.bind("SUPER" .. " + " .. "F", hl.dsp.exec_cmd(fileManager), { description = "File manager" })
hl.bind("SUPER" .. " + " .. "D", hl.dsp.exec_cmd(menu), { description = "App launcher" })
hl.bind("SUPER" .. " + " .. "B", hl.dsp.exec_cmd(browser), { description = "Browser" })
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'), { description = "Screenshot region to clipboard" })
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/show-binds.sh"), { description = "Show keybind cheat sheet" })
