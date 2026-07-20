#!/bin/bash

# This script removes uninstalled applications. A restart is required.

# /Library/LaunchAgents
# /Library/LaunchDaemons
# ~/Library/LaunchAgents
# launchctl remove com.snap.AssistantService
# launchctl remove com.snap.SnapCameraRemover
# sudo launchctl remove com.snap.AssistantService
# sudo launchctl remove com.snap.SnapCameraRemover
# sudo systemextensionsctl list
# sudo systemextensionsctl uninstall 53AQ936H96 org.pqrs.Karabiner-DriverKit-VirtualHIDDevice
# sudo launchctl remove com.surteesstudios.Bartender
# sudo launchctl remove com.surteesstudios.Bartender5StartAtLoginHelper
# sudo launchctl remove com.surteesstudios.HideMenuBarHelper

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
        # rm -rf -- "$filepath"
    fi

done < "$REMOVE_FILES"

##
# Remove the run time created files
find "/private/var/db/receipts" -name 'Power Manager *.pkg' -type d -print0 | xargs -0 rm -rf
find "/Library/Receipts" -name 'Power Manager *.pkg' -type d -print0 | xargs -0 rm -rf
find "/Library/Preferences" -name 'uk.co.dssw.powermanager.*' -type f -delete
find "/var/root/Library/Preferences" -name 'uk.co.dssw.powermanager.*' -type f -delete

find "/Library/Preferences" -name 'com.microsoft.rdc.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.microsoft.rdc.*' -type f -delete

find "/Library/Preferences" -name 'com.surteesstudios.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.surteesstudios.*' -type f -delete

find "/Library/Preferences" -name 'com.snap.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.snap.*' -type f -delete

find "/Library/Preferences" -name 'org.pqrs.*' -type f -delete
find "/var/root/Library/Preferences" -name 'org.pqrs.*' -type f -delete

find "/Library/Preferences" -name 'com.microsoft.Word*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.microsoft.Word*' -type f -delete

find "/Library/Preferences" -name 'VoicemodAudioDevice*' -type f -delete
find "/var/root/Library/Preferences" -name 'VoicemodAudioDevice*' -type f -delete

find "/Library/Preferences" -name 'com.adguard.mac.adguard*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.adguard.mac.adguard*' -type f -delete

find "/Library/Preferences" -name 'com.utmapp.QEMULauncher*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.utmapp.QEMULauncher*' -type f -delete

find "/Library/Preferences" -name 'EndNote*' -type f -delete
find "/var/root/Library/Preferences" -name 'EndNote*' -type f -delete

find "/Library/Preferences" -name '*Kindle*' -type f -delete
find "/var/root/Library/Preferences" -name '*Kindle*' -type f -delete

find "/Library/Preferences" -name 'com.reactotron*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.reactotron*' -type f -delete

find "/Library/Preferences" -name 'com.amazon.UsbFileManager*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.amazon.UsbFileManager*' -type f -delete

find "/Library/Preferences" -name 'com.bitTorrent*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.bitTorrent*' -type f -delete

find "/Library/Preferences" -name 'com.drbuho.BuhoLaunchpad*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.drbuho.BuhoLaunchpad*' -type f -delete

exit 0
