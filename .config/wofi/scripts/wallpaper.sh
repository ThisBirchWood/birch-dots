#!/usr/bin/env bash
# wallpaper.sh — pick a wallpaper from ~/.wallpapers via wofi, apply with hyprpaper
set -euo pipefail
DIR="${HOME}/.wallpapers"
CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper-thumbs"
[[ -d "$DIR" ]] || { notify-send "wallpaper.sh" "No $DIR"; exit 1; }
mkdir -p "$CACHE"

mapfile -t files < <(find -L "$DIR" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
    -printf '%f\n' | LC_ALL=C sort)
[[ ${#files[@]} -gt 0 ]] || { notify-send "wallpaper.sh" "No images found"; exit 1; }

# Build any missing/stale thumbnails, in parallel.
for f in "${files[@]}"; do
    src="${DIR}/${f}"
    thumb="${CACHE}/${f%.*}.png"
    [[ -f "$thumb" && "$thumb" -nt "$src" ]] && continue
    magick "$src" -thumbnail 360x360^ -strip "$thumb" &
done
wait

RANDOM_LABEL="🎲 Random"
menu="img::text:${RANDOM_LABEL}\n"
for f in "${files[@]}"; do
    menu+="img:${CACHE}/${f%.*}.png:text:${f}\n"
done

line=$(echo -en "$menu" | wofi \
    --dmenu --show dmenu --allow-images --insensitive \
    --define image_size=180 --columns 4 --prompt "Wallpaper" \
    --define sort_order=default --cache-file /dev/null \
    --style "${HOME}/.config/wofi/wallpaper.css" \
    --width 900 --height 620 --define halign=fill --define content_halign=fill)
[[ -n "$line" ]] || exit 0

if [[ "$line" == *"$RANDOM_LABEL"* ]]; then
    WALL="${DIR}/${files[RANDOM % ${#files[@]}]}"
else
    choice="${line##*:text:}"
    WALL="${DIR}/${choice}"
fi

hyprctl hyprpaper wallpaper ",${WALL}"
