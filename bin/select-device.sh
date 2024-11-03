#!/bin/sh

# List available devices and pass them to fzf for selection
devices=$(flutter devices --machine | jq -r '.[] | "\(.name) - \(.id)"')

device=$(echo "$devices" | fzf --height=40% --border=rounded --prompt="Select a Flutter device: ")

# Check if a device was selected
if [ -n "$device" ]; then
  # Extract device ID from the selected line (assuming format "Device Name - DeviceID")
  device_id=$(echo "$device" | awk -F' - ' '{print $2}')

  # Set the selected device ID as an environment variable for Flutter
  echo "$device_id"
else
  echo "No device selected."
  exit 1
fi

