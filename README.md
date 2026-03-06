# Setup
1) Run `bootstrap.sh` to configure system files and install packages
2) Add `monitors.conf` in `~/.config/hypr/` for your specific monitor setup

# Packages
- Used `sudo pacman -Qqen` to get all explicit offical packages
- Used `sudo pacman -Qqem` to get all explicit unofficial AUR packages
## Meaning
- `-Q`: Query local package database
- `-q`: Quiet flag, print only package name
- `-e`: Only show **explicitly** installed packages
- `-n`: Native packages only
- `-m`: Foreign packages only
