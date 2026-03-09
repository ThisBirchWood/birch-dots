#!/usr/bin/env bash
# =============================================================================
# birch-dots bootstrap.sh
# Goes from a bare Arch install to a fully configured Hyprland desktop.
# Run as your normal user (with sudo access), NOT as root.
# =============================================================================

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$REPO_ROOT/packages"

# Colours
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log()  { echo -e "${GREEN}==>${NC} $*"; }
warn() { echo -e "${YELLOW}[!]${NC} $*"; }
die()  { echo -e "${RED}[✗]${NC} $*"; exit 1; }

# Guard: must not run as root
[[ "$EUID" -ne 0 ]] || die "Run as your normal user, not root."

# =============================================================================
# 1. SYSTEM SETUP
# =============================================================================

log "Setting locale (en_IE.UTF-8)"
sudo sed -i 's/^#en_IE.UTF-8 UTF-8/en_IE.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen
echo "LANG=en_IE.UTF-8" | sudo tee /etc/locale.conf > /dev/null

log "Setting keymap (uk)"
echo "KEYMAP=uk" | sudo tee /etc/vconsole.conf > /dev/null

log "Setting timezone (Europe/Dublin)"
sudo ln -sf /usr/share/zoneinfo/Europe/Dublin /etc/localtime
sudo hwclock --systohc

log "Setting hostname"
read -rp "  Enter hostname [dylanvm]: " HOSTNAME
HOSTNAME="${HOSTNAME:-dylanvm}"
echo "$HOSTNAME" | sudo tee /etc/hostname > /dev/null
sudo tee /etc/hosts > /dev/null <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain $HOSTNAME
EOF

# =============================================================================
# 2. NETWORKING
# =============================================================================

log "Installing and enabling NetworkManager"
sudo pacman -S networkmanager
sudo systemctl enable --now NetworkManager

# =============================================================================
# 3. PACMAN SETUP
# =============================================================================

log "Configuring pacman (colour + parallel downloads)"
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i 's/^#ParallelDownloads.*/ParallelDownloads = 5/' /etc/pacman.conf

log "Updating mirrors and syncing package database"
sudo pacman -Sy --noconfirm reflector 2>/dev/null || true
sudo reflector --country Ireland,Germany --age 12 --protocol https \
    --sort rate --save /etc/pacman.d/mirrorlist 2>/dev/null \
    || warn "reflector failed, using existing mirrorlist"
sudo pacman -Syyu --noconfirm

# =============================================================================
# 4. PACMAN PACKAGES
# =============================================================================

log "Installing pacman packages"
for file in "$PKG_DIR"/pacman/*.txt; do
    log "  → $(basename "$file")"
    # base/linux/base-devel already installed; --needed skips them safely
    sudo pacman -S --needed --noconfirm - < "$file" || \
        warn "Some packages in $(basename "$file") failed — continuing"
done

# =============================================================================
# 5. ZSH AS DEFAULT SHELL
# =============================================================================

log "Setting zsh as default shell"
chsh -s /bin/zsh

# =============================================================================
# 6. YAY (AUR HELPER)
# =============================================================================

log "Installing yay"
if ! command -v yay &>/dev/null; then
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    pushd "$tmpdir/yay" > /dev/null
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf "$tmpdir"
else
    log "  yay already installed, skipping"
fi

# =============================================================================
# 7. AUR PACKAGES
# =============================================================================

log "Installing AUR packages"
for file in "$PKG_DIR"/aur/*.txt; do
    log "  → $(basename "$file")"
    yay -S --needed --noconfirm - < "$file" || \
        warn "Some AUR packages in $(basename "$file") failed — continuing"
done

# =============================================================================
# 8. POWERLEVEL10K
# =============================================================================

log "Installing Powerlevel10k"
if [[ ! -d "$HOME/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "$HOME/powerlevel10k"
else
    log "  powerlevel10k already present, skipping"
fi

# =============================================================================
# 9. DOTFILES
# =============================================================================

log "Deploying dotfiles from repo into HOME"
# Copy everything except git internals, system/, packages/, bootstrap.sh
rsync -av --exclude='.git' \
          --exclude='system/' \
          --exclude='packages/' \
          --exclude='bootstrap.sh' \
          --exclude='README.md' \
          --exclude='dotfiles_log.txt' \
          "$REPO_ROOT/" "$HOME/"

# Make scripts executable
find "$HOME/.config" -name "*.sh" -exec chmod +x {} \;

# =============================================================================
# 10. SYSTEM CONFIG FILES (SDDM etc.)
# =============================================================================

log "Applying SDDM configuration"
sudo mkdir -p /etc/sddm.conf.d
sudo cp -a "$REPO_ROOT/system/sddm.conf.d/." /etc/sddm.conf.d/
sudo cp -a "$REPO_ROOT/system/sddm/." /etc/sddm/
sudo chown -R root:root /etc/sddm.conf.d /etc/sddm
sudo chmod 644 /etc/sddm.conf.d/*.conf
sudo chmod +x /etc/sddm/scripts/Xsetup 2>/dev/null || true

log "Enabling SDDM"
sudo systemctl enable sddm

# =============================================================================
# 11. SERVICES
# =============================================================================

log "Enabling system services"
sudo systemctl enable docker
sudo usermod -aG docker "$USER"
sudo systemctl enable earlyoom 2>/dev/null || true

# =============================================================================
# 12. MONITOR CONFIG (machine-specific)
# =============================================================================

MONITORS_CONF="$HOME/.config/hypr/monitors.conf"
if [[ ! -f "$MONITORS_CONF" ]]; then
    warn "No monitors.conf found — creating a safe default (single monitor)"
    cat > "$MONITORS_CONF" <<'EOF'
# Auto-generated default — replace with your actual monitor config.
# See: https://wiki.hyprland.org/Configuring/Monitors/
monitor = , preferred, auto, 1
EOF
    warn "Edit ~/.config/hypr/monitors.conf before starting Hyprland."
else
    log "monitors.conf already exists, skipping"
fi

# =============================================================================
# 13. VSCODE EXTENSIONS
# =============================================================================

EXTENSIONS_FILE="$HOME/.config/Code/User/extensions.txt"
if command -v code &>/dev/null && [[ -f "$EXTENSIONS_FILE" ]]; then
    log "Installing VS Code extensions"
    while IFS= read -r ext; do
        code --install-extension "$ext" --force 2>/dev/null || true
    done < "$EXTENSIONS_FILE"
else
    warn "VS Code not found or extensions.txt missing — skipping"
fi

# =============================================================================
# 14. WALLPAPER DIRECTORY
# =============================================================================

log "Creating wallpaper directory"
mkdir -p "$HOME/.wallpapers"
warn "Add wallpapers to ~/.wallpapers/ for hyprpaper + wofi selector to work."

# =============================================================================
# DONE
# =============================================================================

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  Bootstrap complete!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "  Next steps:"
echo "  1. Edit ~/.config/hypr/monitors.conf for your display layout"
echo "  2. Add wallpapers to ~/.wallpapers/"
echo "  3. Run p10k configure after first zsh launch"
echo "  4. Reboot"
echo ""
