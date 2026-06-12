#!/bin/bash
#
# Part of DssW Power Manager
# Copyright (c) 2022 Dragon Systems Software Limited
# Support: support@dssw.co.uk
#
# This script removes Power Manager from the target drive. A restart is required.

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

# find / \
#   \( -path "*com.apple.TimeMachine.localsnapshots*" \
#      -o -path "/System/Volumes/Preboot*" \
#      -o -path "/System/Volumes/VM*" \) \
#   -prune -o \
#   -iname "*OneDrive*" -print 2>/dev/null

# Ensure script has root authority
if ! [ "$(id -u)" = 0 ]; then
  echo "You must be root to run this script" 2>&1
  exit 1
fi

REMOVE_FILES=(
  '/Library/LaunchDaemons/uk.co.dssw.powermanager.pmd.plist'  # Launchd job ticket
  '/Library/Logs/uk.co.dssw.powermanager' # daemon log files; PM5.10.1+
  '/Applications/Power Manager.app' # Application
  '/etc/pam.d/uk.co.dssw.powermanager' # PAM policy
  '/Library/Application Support/Power Manager' # Shared tools and core engine
  '/Library/Automator/PMToggleScheduler.action'
  '/Library/Frameworks/PowerManager.framework' # Shared framework
  '/Library/LaunchAgents/uk.co.dssw.pmnotify.login.plist' # Launchd job ticket
  '/Library/LaunchAgents/uk.co.dssw.pmnotify.plist' # Launchd job ticket
  '/Library/LaunchAgents/uk.co.dssw.pmuser.plist' # Launchd job ticket
  '/Library/LaunchDaemons/uk.co.dssw.powermanager.installer.plist' # Automated installer job ticket
  '/Library/PrivilegedHelperTools/uk.co.dssw.powermanager.installer' # Automated installer
  '/Library/Caches/uk.co.dssw.powermanager.certtool.cache.json' # certtool cache
  '/Library/Documentation/Help/Power Manager Help' # Help Book symlink
  '/Library/PreferencePanes/Power Manager.prefPane' # Preference pane
  '/Library/StartupItems/PowerManager' # StartupItem (Mac OS X 10.3.9)
  '/Library/Widgets/Power Manager.wdgt' # Dashboard widget (Mac OS X 10.4+)
  '/System/Library/CoreServices/SecurityAgentPlugins/pmauth.bundle' # loginwindow plugin
  '/Library/LaunchAgents/uk.co.dssw.pmuser.plist'
  '/Library/LaunchDaemons/uk.co.dssw.powermanager.pmd.plist'
  '/System/Volumes/Data/Users/andres/Library/Containers/uk.co.dssw.update.feed'
  '/Library/CoreMediaIO/Plug-Ins/DAL/SnapCamera.plugin'
  '/Library/LaunchDaemons/com.snap.SnapCameraRemover.plist'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/16777235_530'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/16777235_530/functions.data'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/16777235_530/functions.list'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/32024'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/32024/libraries.list'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metal/32024/libraries.data'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera/com.apple.metalfe'
  '/System/Volumes/Data/Users/andres/Library/Caches/com.plausiblelabs.crashreporter.data/com.snap.SnapCamera'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.snap.SnapCamera'
  '/Library/SystemExtensions/0535073D-C057-4993-BE3F-28160EE596D8/org.pqrs.Karabiner-DriverKit-VirtualHIDDevice.dext'
  '/Library/SystemExtensions/0535073D-C057-4993-BE3F-28160EE596D8/org.pqrs.Karabiner-DriverKit-VirtualHIDDevice.dext/org.pqrs.Karabiner-DriverKit-VirtualHIDDevice'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/0/sysdiagnose.616-3Tirjz/usernoted/apps/com.ideashower.ReadItLaterPro.txt'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.ideashower.ReadItLaterPro'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.ideashower.ReadItLaterPro/com.ideashower.ReadItLaterPro'
  '/System/Volumes/Data/Users/andres/Library/Group Containers/group.com.apple.UserNotifications/Library/UserNotifications/Remote/default/SectionSettings/com.ideashower.ReadItLaterPro.sectionsettings'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.microsoft.rdc.macos'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.microsoft.rdc.macos/com.microsoft.rdc.macos'
  '/System/Volumes/Data/Users/andres/Library/Application Scripts/UBF8T346G9.com.microsoft.rdc'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.microsoft.rdc.macos'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.microsoft.rdc.macos/com.microsoft.rdc.macos'
  '/System/Volumes/Data/Users/andres/Library/Application Scripts/UBF8T346G9.com.microsoft.rdc'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.surteesstudios.Bartender'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.surteesstudios.Bartender5StartAtLoginHelper'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.surteesstudios.HideMenuBarHelper'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.surteesstudios.HideMenuBarHelper/com.surteesstudios.HideMenuBarHelper'
  '/System/Volumes/Data/Users/andres/Library/Daemon Containers/64B2A130-01F5-4F36-9295-C235C808254D/Data/ActionTranscript/com.surteesstudios.Bartender'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/developer.apple.wwdc-Release'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/developer.apple.wwdc-Release/developer.apple.wwdc-Release'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/0/sysdiagnose.616-3Tirjz/usernoted/apps/com.microsoft.OneDrive-mac.txt'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.microsoft.OneDrive-mac'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.microsoft.OneDrive-mac/com.microsoft.OneDrive-mac'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.microsoft.OneDrive-mac.FileProvider'
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.microsoft.OneDrive-mac.FinderSync'
  '/System/Volumes/Data/Users/andres/Library/Application Support/FileProvider/com.microsoft.OneDrive-mac.FileProvider'
  '/System/Volumes/Data/Users/andres/Library/Application Support/FileProvider/com.microsoft.OneDrive-mac.FileProvider/OneDrive - UNIÃO DOS ESCOTEIROS DO BRASIL'
  '/System/Volumes/Data/Users/andres/Library/Preferences/com.apple.FileProvider/com.microsoft.OneDrive-mac.FileProvider'
  '/System/Volumes/Data/Users/andres/Library/Preferences/com.apple.FileProvider/com.microsoft.OneDrive-mac.FileProvider/OneDrive - UNIÃO DOS ESCOTEIROS DO BRASIL.plist'
  '/System/Volumes/Data/Users/andres/Library/Preferences/com.apple.FileProvider/com.microsoft.OneDrive-mac.FileProvider/OneDrive.plist'
  '/System/Volumes/Data/Users/andres/Library/Application Scripts/UBF8T346G9.OneDriveSyncClientSuite'
  '/System/Volumes/Data/Users/andres/Library/Application Scripts/UBF8T346G9.OfficeOneDriveSyncIntegration'
  '/System/Volumes/Data/Users/andres/Library/Group Containers/UBF8T346G9.OfficeOneDriveSyncIntegration'
  '/System/Volumes/Data/Users/andres/Library/Group Containers/UBF8T346G9.OfficeOneDriveSyncIntegration/Library/Application Scripts/UBF8T346G9.OfficeOneDriveSyncIntegration'
  );
for (( i = 0 ; i < "${#REMOVE_FILES[@]}" ; i++ ))
do
  FILEPATH="${REMOVE_FILES[$i]}"
  if [ -e "$FILEPATH" ]; then
    echo "Removing: ${FILEPATH}"
    rm -rf "${FILEPATH}"
  fi
done

##
# Remove the run time created files
find "/private/var/db/receipts" -name 'Power Manager *.pkg' -type d -print0 | xargs -0 rm -rf
find "/Library/Receipts" -name 'Power Manager *.pkg' -type d -print0 | xargs -0 rm -rf
find "/Library/Preferences" -name 'uk.co.dssw.powermanager.*' -type f -delete
find "/var/root/Library/Preferences" -name 'uk.co.dssw.powermanager.*' -type f -delete

find "/Library/Preferences" -name 'com.ideashower.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.ideashower.*' -type f -delete

find "/Library/Preferences" -name 'com.microsoft.OneDrive*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.microsoft.OneDrive*' -type f -delete

find "/Library/Preferences" -name 'com.microsoft.rdc.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.microsoft.rdc.*' -type f -delete

find "/Library/Preferences" -name 'com.surteesstudios.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.surteesstudios.*' -type f -delete

find "/Library/Preferences" -name 'com.snap.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.snap.*' -type f -delete

find "/Library/Preferences" -name 'org.pqrs.*' -type f -delete
find "/var/root/Library/Preferences" -name 'org.pqrs.*' -type f -delete

exit 0
