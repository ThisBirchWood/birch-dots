#!/usr/bin/env bash

print_icon() {
  if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then
    echo ""
  else
    echo ""
  fi
}

# Print once on startup
print_icon

# Subscribe to PipeWire events
wpctl subscribe @DEFAULT_AUDIO_SOURCE@ | while read -r _; do
  print_icon
done

