#!/usr/bin/env bash
DATA=$(hyprctl -j binds | jq -r '
  def mods(m):
    [ if m >= 64 then "SUPER" else empty end,
      if (m % 16) >= 8 then "ALT" else empty end,
      if (m % 8) >= 4 then "CTRL" else empty end,
      if (m % 2) >= 1 then "SHIFT" else empty end ] | join("+");
  [ .[] | select(.has_description)
    | { k: "\(if .modmask > 0 then mods(.modmask) + "+" else "" end)\(.key)",
        d: .description } ]
  | sort_by(.k)
  | (map(.k | length) | max) as $w
  | .[] | "\(.k + (" " * ($w - (.k | length))))  \(.d)"
')

COLS=$(awk '{ if (length > m) m = length } END { print m }' <<< "$DATA")
ROWS=$(wc -l <<< "$DATA")

PRW=$(( COLS * 2 + 4 ))
PX=$(( PRW * 7 + 60 ))
PY=$(( (ROWS / 2 + 2) * 18 + 60 ))

pr -2 -t -w "$PRW" <<< "$DATA" \
  | yad --text-info --title="Hyprland Keybinds" \
        --width="$PX" --height="$PY" --center \
        --fontname="monospace 10" --no-buttons --wrap=false
