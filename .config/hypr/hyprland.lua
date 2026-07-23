local monitors = require("monitors")

-- Set programs that you use
terminal = "kitty"
fileManager = "thunar"
menu = "wofi --show drun"
browser = "brave"

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        initial_workspace_tracking = 1,
    },
})

-- Envs
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

local keybinds = require("keybinds")
local input = require("input")
local applications = require("applications")
local decorations = require("decoration")
local workspaces = require("workspaces")

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal &")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("nextcloud")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprctl setcursor breeze 24")
end)

-- Exec (run every reload)
hl.on("config.reloaded", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark")
end)
