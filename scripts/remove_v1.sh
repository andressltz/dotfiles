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

# Ensure script has root authority
if ! [ "$(id -u)" = 0 ]; then
  echo "You must be root to run this script" 2>&1
  exit 1
fi

REMOVE_FILES_LIST=(
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
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/0/sysdiagnose.616-3Tirjz/usernoted/apps/com.microsoft.Word.txt'
  '/System/Volumes/Data/Users/andres/Library/Daemon Containers/C55F6646-10ED-474D-A28E-6E4BDF61007B/Data/SpinTracer/com.microsoft.Word'
  '/Library/Audio/Plug-Ins/HAL/VoicemodAudioDevice.driver'
  '/Library/Audio/Plug-Ins/HAL/VoicemodAudioDevice.driver/Contents/MacOS/VoicemodAudioDevice'
  '/Library/SystemExtensions/FFABED8B-11E4-4030-AB54-014513621EBA/com.adguard.mac.adguard.network-extension.systemextension'
  '/Library/SystemExtensions/FFABED8B-11E4-4030-AB54-014513621EBA/com.adguard.mac.adguard.network-extension.systemextension/Contents/MacOS/com.adguard.mac.adguard.network-extension'
  '/Users/andres/Library/Application Scripts/TC3Q7MAJXF.com.adguard.mac'
  '/private/var/root/Library/Application Scripts/TC3Q7MAJXF.com.adguard.mac'
  '/private/var/root/Library/Application Scripts/com.adguard.mac.adguard.network-extension'
  '/private/var/root/Library/Group Containers/TC3Q7MAJXF.com.adguard.mac'
  '/private/var/root/Library/Group Containers/TC3Q7MAJXF.com.adguard.mac/Library/Application Support/com.adguard.mac.adguard'
  '/private/var/root/Library/Group Containers/TC3Q7MAJXF.com.adguard.mac/Library/Application Scripts/TC3Q7MAJXF.com.adguard.mac'
  '/private/var/root/Library/Group Containers/TC3Q7MAJXF.com.adguard.mac/Library/Logs/com.adguard.mac.adguard'
  '/private/var/root/Library/Containers/com.adguard.mac.adguard.network-extension'
  '/private/var/root/Library/Containers/com.adguard.mac.adguard.network-extension/Data/Library/Application Scripts/com.adguard.mac.adguard.network-extension'
  '/private/var/root/Library/Containers/com.adguard.mac.adguard.network-extension/Data/Library/HTTPStorages/com.adguard.mac.adguard.network-extension'
  '/private/var/root/Library/Containers/com.adguard.mac.adguard.network-extension/Data/Library/Caches/com.adguard.mac.adguard.network-extension'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.adguard.mac.adguard'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.adguard.mac.adguard-installer'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.adguard.mac.adguard.safari-assistant'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.adguard.mac.adguard.safari-assistant/com.adguard.mac.adguard.safari-assistant'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.adguard.mac.adguard.loginhelper'
  '/Users/andres/Library/Application Scripts/YJW8D95H2C.com.istudiezteam'
  '/Applications/EndNote Cite While You Write'
  '/Library/Application Support/Microsoft/Office365/User Content.localized/Startup.localized/Word/EndNote CWYW Word 16.bundle'
  '/Users/andres/Library/Logs/EndNote Cite While You Write Installer.log'
  '/Users/andres/Library/Application Support/Amazon/SendToKindle'
  '/Users/andres/Library/Application Support/Amazon/SendToKindle/update/SendToKindleForMac-installer.pkg'
  '/Users/andres/Library/Preferences/com.amazon.SendToKindle.plist'
  '/Users/andres/Library/Logs/SendToKindleUninstall.log'
  '/Users/andres/Library/Logs/SendToKindleInstall.log'
  '/private/var/db/receipts/com.amazon.SendToKindleMacInstaller.pkg.plist'
  '/private/var/db/receipts/com.amazon.SendToKindleMacInstaller.pkg.bom'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.amazon.SendToKindleUninstaller'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.amazon.UsbFileManager'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.amazon.SendToKindle'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/lo.cafe.NotchNook'
  );
for (( i = 0 ; i < "${#REMOVE_FILES_LIST[@]}" ; i++ ))
do
  FILEPATH="${REMOVE_FILES_LIST[$i]}"
  if [ -e "$FILEPATH" ]; then
    echo "Removing: ${FILEPATH}"
    # rm -rf "${FILEPATH}"
  fi
done

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

exit 0
