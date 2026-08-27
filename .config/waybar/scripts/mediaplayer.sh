#!/usr/bin/env bash
#
# waybar custom module: shows currently playing media, mac-menu-bar style.
# Outputs a single JSON line: {"text":..., "tooltip":..., "class":..., "alt":...}
# waybar re-runs this on an interval (set in config.jsonc) and re-renders.

# --status-format lets us build one compact string per call instead of
# separate playerctl invocations for title/artist/status (fewer subprocess
# spawns = faster polling, matters since waybar calls this every ~1s).
STATUS=$(playerctl -a metadata --format '{{status}}|{{artist}}|{{title}}|{{playerName}}' 2>/dev/null | head -n1)

if [ -z "$STATUS" ]; then
    # No MPRIS players running at all -> render nothing (empty text hides
    # the module if `"class": "hidden"` is styled to display:none, but
    # simplest is just an empty text with no tooltip).
    echo '{"text": "", "tooltip": "No media playing", "class": "hidden"}'
    exit 0
fi

# IFS='|' read splits our pipe-delimited format string into vars.
IFS='|' read -r PSTATUS ARTIST TITLE PLAYER <<< "$STATUS"

# Playing vs Paused get different CSS classes so you can dim the paused state.
case "$PSTATUS" in
    Playing) ICON="" ;;   # nerd-font play glyph
    Paused)  ICON="" ;;   # nerd-font pause glyph
    *)       ICON="" ;;
esac

# Truncate long titles so the bar doesn't blow out — cut at 30 chars,
# append an ellipsis. This is bash parameter expansion, not a subprocess.
LABEL="${ARTIST} - ${TITLE}"
if [ "${#LABEL}" -gt 32 ]; then
    LABEL="${LABEL:0:29}..."
fi

# Escape double quotes so we don't break the JSON if a title contains one.
LABEL_ESC=$(printf '%s' "$LABEL" | sed 's/"/\\"/g')
TOOLTIP_ESC=$(printf '%s — %s\n(%s)' "$ARTIST" "$TITLE" "$PLAYER" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

CLASS="media-${PSTATUS,,}"  # bash ${var,,} lowercases -> "media-playing" / "media-paused"

echo "{\"text\": \"${ICON} ${LABEL_ESC}\", \"tooltip\": \"${TOOLTIP_ESC}\", \"class\": \"${CLASS}\", \"alt\": \"${PSTATUS}\"}"
