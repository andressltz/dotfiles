#!/bin/bash
#
# Part of DssW Power Manager
# Copyright (c) 2022 Dragon Systems Software Limited
# Support: support@dssw.co.uk
#
# This script removes Power Manager from the target drive. A restart is required.

# TARGET_DRIVE="$3"
TARGET_DRIVE="/"

# /Library/LaunchAgents
# /Library/LaunchDaemons
# ~/Library/LaunchAgents
# sudo find / -iname "*com.snap*" 2>/dev/null
# sudo find / -iname "*snapcamera*" 2>/dev/null
# launchctl remove com.snap.AssistantService
# launchctl remove com.snap.SnapCameraRemover
# sudo launchctl remove com.snap.AssistantService
# sudo launchctl remove com.snap.SnapCameraRemover
# sudo systemextensionsctl list
# sudo systemextensionsctl uninstall 53AQ936H96 org.pqrs.Karabiner-DriverKit-VirtualHIDDevice

# Ensure script has root authority
if ! [ "$(id -u)" = 0 ]; then
  echo "You must be root to run this script" 2>&1
  exit 1
fi

##
# Remove static files
REMOVE_FILES=(
  # ...PM5 only
  'Library/LaunchDaemons/uk.co.dssw.powermanager.pmd.plist'  # Launchd job ticket
  'Library/Logs/uk.co.dssw.powermanager' # daemon log files; PM5.10.1+
  # ...PM3+PM4
  'Applications/Power Manager.app' # Application
  'etc/pam.d/uk.co.dssw.powermanager' # PAM policy
  'Library/Application Support/Power Manager' # Shared tools and core engine
  'Library/Automator/PMCancelEvents.action'
  'Library/Automator/PMDelayEvents.action'
  'Library/Automator/PMDeleteEvents.action'
  'Library/Automator/PMEvent.definition'
  'Library/Automator/PMEventsToStrings.caction'
  'Library/Automator/PMExportEvents.action'
  'Library/Automator/PMFilterEvents.action'
  'Library/Automator/PMImportEvents.action'
  'Library/Automator/PMListEvents.action'
  'Library/Automator/PMNewEvent.action'
  'Library/Automator/PMNextEvent.action'
  'Library/Automator/PMResetEvents.action'
  'Library/Automator/PMToggleScheduler.action'
  'Library/Frameworks/PowerManager.framework' # Shared framework
  'Library/LaunchAgents/uk.co.dssw.pmnotify.login.plist' # Launchd job ticket
  'Library/LaunchAgents/uk.co.dssw.pmnotify.plist' # Launchd job ticket
  'Library/LaunchAgents/uk.co.dssw.pmuser.plist' # Launchd job ticket
  'Library/LaunchDaemons/uk.co.dssw.pmd.plist' # Launchd job ticket
  'Library/LaunchDaemons/uk.co.dssw.powermanager.installer.plist' # Automated installer job ticket
  'Library/PrivilegedHelperTools/uk.co.dssw.powermanager.installer' # Automated installer
  'Library/Caches/uk.co.dssw.powermanager.certtool.cache.json' # certtool cache
  'var/tmp/uk.co.dssw.powermanager' # Unix socket directory
  # ...PM3 only
  'Library/Documentation/Help/Power Manager Help' # Help Book symlink
  'Library/PreferencePanes/Power Manager.prefPane' # Preference pane
  'Library/StartupItems/PowerManager' # StartupItem (Mac OS X 10.3.9)
  'Library/Widgets/Power Manager.wdgt' # Dashboard widget (Mac OS X 10.4+)
  'System/Library/CoreServices/SecurityAgentPlugins/pmauth.bundle' # loginwindow plugin
  'usr/local/powermanager' # Unix daemon
  'Library/LaunchAgents/uk.co.dssw.pmnotify.plist'
  'Library/LaunchAgents/uk.co.dssw.pmuser.plist'
  'Library/LaunchDaemons/uk.co.dssw.powermanager.pmd.plist'
  'System/Volumes/Data/Library/LaunchAgents/uk.co.dssw.pmnotify.plist'
  'System/Volumes/Data/Library/LaunchAgents/uk.co.dssw.pmuser.plist'
  'System/Volumes/Data/Library/LaunchDaemons/uk.co.dssw.powermanager.pmd.plist'
  'System/Volumes/Data/private/var/db/receipts/uk.co.dssw.powermanager.launchdaemons.plist'
  'System/Volumes/Data/private/var/db/receipts/uk.co.dssw.powermanager.launchdaemons.bom'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/uk.co.dssw.powermanager.client.pmnotify'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/uk.co.dssw.powermanager.client.pmnotify/uk.co.dssw.powermanager.client.pmnotify'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/uk.co.dssw.powermanager.standard'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/uk.co.dssw.powermanager.standard/uk.co.dssw.powermanager.standard'
  'System/Volumes/Data/Users/andres/Library/Application Scripts/uk.co.dssw.update.feed'
  'System/Volumes/Data/Users/andres/Library/Containers/uk.co.dssw.update.feed'
  'System/Volumes/Data/Users/andres/Library/Containers/uk.co.dssw.update.feed/Data/Library/Application Scripts/uk.co.dssw.update.feed'
  'Library/CoreMediaIO/Plug-Ins/DAL/SnapCamera.plugin'
  'Library/LaunchDaemons/com.snap.SnapCameraRemover.plist'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/16777235_530'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/16777235_530/functions.data'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/16777235_530/functions.list'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/32024'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/32024/libraries.list'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/32024/libraries.data'
  'System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metalfe'
  'System/Volumes/Data/Users/andres/Library/Caches/com.plausiblelabs.crashreporter.data/com.snap.SnapCamera'
  'private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera'
  'Library/SystemExtensions/0535073D-C057-4993-BE3F-28160EE596D8/org.pqrs.Karabiner-DriverKit-VirtualHIDDevice.dext'
  'Library/SystemExtensions/0535073D-C057-4993-BE3F-28160EE596D8/org.pqrs.Karabiner-DriverKit-VirtualHIDDevice.dext/org.pqrs.Karabiner-DriverKit-VirtualHIDDevice'
  );
for (( i = 0 ; i < "${#REMOVE_FILES[@]}" ; i++ ))
do
  FILEPATH="${TARGET_DRIVE}${REMOVE_FILES[$i]}"
  if [ -e "$FILEPATH" ]; then
    echo "Removing: ${FILEPATH}"
    rm -rf "${FILEPATH}"
  fi
done

##
# Remove the run time created files
find "${TARGET_DRIVE}private/var/db/receipts" -name 'Power Manager *.pkg' -type d -print0 | xargs -0 rm -rf
find "${TARGET_DRIVE}Library/Receipts" -name 'Power Manager *.pkg' -type d -print0 | xargs -0 rm -rf
find "${TARGET_DRIVE}Library/Preferences" -name 'uk.co.dssw.powermanager.*' -type f -delete
find "${TARGET_DRIVE}var/root/Library/Preferences" -name 'uk.co.dssw.powermanager.*' -type f -delete

exit 0
