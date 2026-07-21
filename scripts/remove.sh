#!/bin/bash

# This script removes uninstalled applications. A restart is required.

# /Library/LaunchAgents
# /Library/LaunchDaemons
# ~/Library/LaunchAgents

# launchctl remove com.snap.AssistantService
# launchctl remove com.snap.SnapCameraRemover
# sudo launchctl remove com.snap.AssistantService
# sudo launchctl remove com.snap.SnapCameraRemover

# com.alienator88.Pearcleaner.PearcleanerHelper
# com.bitgapp.eqmac.helper

# sudo systemextensionsctl list
# sudo systemextensionsctl uninstall 53AQ936H96 org.pqrs.Karabiner-DriverKit-VirtualHIDDevice

# MusicBrainz Picard

# Ensure script has root authority
if ! [ "$(id -u)" = 0 ]; then
  echo "You must be root to run this script" 2>&1
  exit 1
fi

REMOVE_FILES="remove_files_to_remove.txt"

while IFS= read -r filepath || [[ -n "$filepath" ]]; do
    [[ -z "$filepath" ]] && continue

    if [ -e "$filepath" ]; then
        echo "Removendo: $filepath"
        rm -rf -- "$filepath"
    fi

done < "$REMOVE_FILES"

exit 0
