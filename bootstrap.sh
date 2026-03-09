#!/usr/bin/env bash
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$REPO_ROOT/packages"

echo "==> Installing pacman packages"

for file in "$PKG_DIR"/pacman/*.txt; do
    echo "Installing $(basename "$file")"
    sudo pacman -S --needed --noconfirm - < "$file"
done


echo "==> Installing yay (AUR helper) if missing"

if ! command -v yay &> /dev/null; then
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    pushd "$tmpdir/yay"
    makepkg -si --noconfirm
    popd
    rm -rf "$tmpdir"
fi


echo "==> Installing AUR packages"

for file in "$PKG_DIR"/aur/*.txt; do
    echo "Installing $(basename "$file")"
    yay -S --needed --noconfirm - < "$file"
done


echo "==> Applying SDDM configuration"

sudo mkdir -p /etc/sddm.conf.d
sudo cp -a "$REPO_ROOT/system/sddm.conf.d" /etc/
sudo cp -a "$REPO_ROOT/system/sddm" /etc/

sudo chown -R root:root /etc/sddm.conf.d /etc/sddm
sudo chmod -R 644 /etc/sddm.conf.d /etc/sddm


echo "==> Bootstrap complete"
