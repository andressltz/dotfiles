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
# launchctl remove com.microsoft.Word
# launchctl remove com.ideashower.ReadItLaterPro.AddToPocketExtension
# launchctl remove com.ideashower.ReadItLaterPro.iMessageExtension
# launchctl remove com.ideashower.ReadItLaterPro.PushNotificationServiceExtension
# launchctl remove com.ideashower.ReadItLaterPro.PushNotificationStoryExtension
# launchctl remove com.ideashower.ReadItLaterPro.Widget-Extension
# launchctl remove com.ideashower.ReadItLaterPro

# sudo find / \
#   \( -path "*com.apple.TimeMachine.localsnapshots*" \
#      -o -path "/System/Volumes/Data/.MobileBackups*" \
#      -o -path "/Volumes/.timemachine*" \
#      -o -path "/Volumes/com.apple.TimeMachine*" \
#      -o -path "/System/Volumes/Update*" \
#      -o -path "/System/Volumes/Preboot*" \
#      -o -path "/System/Volumes/VM*" \) \
#   -prune -o \
#   -iname "*uk.co.dssw.powermanager*" -print 2>/dev/null

# Reactotron
# MusicBrainz Picard
# uTorrent Web
# Send to Kindle
# USB File Manager

# sudo find \
#   /Applications \
#   /Library \
#   /Users \
#   /etc \
#   /private \
#   \( -iname "*uk.co.dssw.powermanager*" \
#     -o -iname "*com.ideashower*" \
#     -o -iname "*com.microsoft.rdc*" \
#     -o -iname "*com.microsoft.Word*" \
#     -o -iname "*com.snap*" \
#     -o -iname "*snapcamera*" \
#     -o -iname "*org.pqrs*" \
#     -o -iname "*group.pro.listy*" \
#     -o -iname "*net.pornel*" \
#     -o -iname "*com.surteesstudios*" \
#     -o -iname "*voicemodaudio*" \
#     -o -iname "*com.adguard*" \
#     -o -iname "*com.istudiezteam*" \
#     -o -iname "*com.utmapp*" \
#     -o -iname "*EndNote *" \
#     -o -iname "*bartender*" \) \
#   -print 2>/dev/null

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
  '/System/Volumes/Data/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/0/sysdiagnose.616-3Tirjz/usernoted/apps/com.microsoft.Word.txt'
  '/System/Volumes/Data/Users/andres/Library/Application Support/Logi/LogiPluginService/Temp/ApplicationIcons/com.microsoft.Word.png'
  '/System/Volumes/Data/Users/andres/Library/Daemon Containers/C55F6646-10ED-474D-A28E-6E4BDF61007B/Data/SpinTracer/com.microsoft.Word'
  '/Users/andres/Library/Containers/4D6F3808-269A-4162-AFAA-D24D9D8392B5/Data/Library/Application Scripts/com.ideashower.ReadItLaterPro.AddToPocketExtension'
  '/Users/andres/Library/Containers/0B79329F-3DFE-4D9E-8249-50B2EE87E996/Data/Library/Application Scripts/com.ideashower.ReadItLaterPro.iMessageExtension'
  '/Users/andres/Library/Containers/799215B0-B6B5-4310-A725-AA43600CDF3B/Data/Library/Application Scripts/com.ideashower.ReadItLaterPro.PushNotificationServiceExtension'
  '/Users/andres/Library/Containers/BF32C278-7EF4-460E-AA45-7B59EE094995/Data/Library/Application Scripts/com.ideashower.ReadItLaterPro.PushNotificationStoryExtension'
  '/Users/andres/Library/Containers/FED7DBFF-9C3F-42F4-BBC3-3E804FB95124/Data/Library/Application Scripts/com.ideashower.ReadItLaterPro.Widget-Extension'
  '/Users/andres/Library/Containers/FED7DBFF-9C3F-42F4-BBC3-3E804FB95124/Data/Library/HTTPStorages/com.ideashower.ReadItLaterPro.Widget-Extension'
  '/Users/andres/Library/Containers/0FBE1A01-DAAD-4834-9F5E-C800AC4ACD71/Data/Library/Saved Application State/com.ideashower.ReadItLaterPro~iosmac.savedState'
  '/Users/andres/Library/Containers/0FBE1A01-DAAD-4834-9F5E-C800AC4ACD71/Data/Library/Preferences/com.ideashower.ReadItLaterPro.plist'
  '/Users/andres/Library/Containers/0FBE1A01-DAAD-4834-9F5E-C800AC4ACD71/Data/Library/Application Scripts/com.ideashower.ReadItLaterPro'
  '/Users/andres/Library/Containers/0FBE1A01-DAAD-4834-9F5E-C800AC4ACD71/Data/Library/HTTPStorages/com.ideashower.ReadItLaterPro'
  '/Users/andres/Library/Containers/0FBE1A01-DAAD-4834-9F5E-C800AC4ACD71/Data/Library/Caches/com.ideashower.ReadItLaterPro'
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
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.utmapp.QEMUHelper'
  '/private/var/folders/wj/b3y8wmt95x57gkd_sbjgmhhc0000gn/C/com.utmapp.QEMUHelper/com.utmapp.QEMULauncher'
  '/Applications/EndNote Cite While You Write'
  '/Library/Application Support/Microsoft/Office365/User Content.localized/Startup.localized/Word/EndNote CWYW Word 16.bundle'
  '/Users/andres/Library/Logs/EndNote Cite While You Write Installer.log'
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

find "/Library/Preferences" -name 'com.microsoft.rdc.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.microsoft.rdc.*' -type f -delete

find "/Library/Preferences" -name 'com.surteesstudios.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.surteesstudios.*' -type f -delete

find "/Library/Preferences" -name 'com.snap.*' -type f -delete
find "/var/root/Library/Preferences" -name 'com.snap.*' -type f -delete

find "/Library/Preferences" -name 'org.pqrs.*' -type f -delete
find "/var/root/Library/Preferences" -name 'org.pqrs.*' -type f -delete

find "/Library/Preferences" -name 'net.pornel.*' -type f -delete
find "/var/root/Library/Preferences" -name 'net.pornel.*' -type f -delete

find "/Library/Preferences" -name 'group.pro.listy*' -type f -delete
find "/var/root/Library/Preferences" -name 'group.pro.listy*' -type f -delete

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

exit 0

# /Applications/EndNote Cite While You Write/Cite While You Write/EndNote CWYW Word 16.bundle
# /Applications/EndNote Cite While You Write/Cite While You Write/EndNote CWYW Word 16.bundle/Contents/MacOS/EndNote CWYW Word 16
# /Applications/EndNote Cite While You Write/Cite While You Write/EndNote CWYW Word 16.bundle/Contents/Resources/EndNote.icns
# /Applications/EndNote Cite While You Write/Cite While You Write/EndNote CWYW Word 16.bundle/Contents/Resources/English.lproj/EndNotePreferencesDialog.nib
# /Applications/EndNote Cite While You Write/Cite While You Write/EndNote CWYW Word 16.bundle/Contents/Resources/English.lproj/EndNoteWebPreferencesDialog.nib
# /Applications/EndNote Cite While You Write/Cite While You Write/EndNote CWYW Word 16.bundle/Contents/Resources/EndNote CWYW Word 16.dotm


# /Library/Application Support/Microsoft/Office365/User Content.localized/Startup.localized/Word/EndNote CWYW Word 16.bundle/Contents/MacOS/EndNote CWYW Word 16
# /Library/Application Support/Microsoft/Office365/User Content.localized/Startup.localized/Word/EndNote CWYW Word 16.bundle/Contents/Resources/EndNote.icns
# /Library/Application Support/Microsoft/Office365/User Content.localized/Startup.localized/Word/EndNote CWYW Word 16.bundle/Contents/Resources/English.lproj/EndNotePreferencesDialog.nib
# /Library/Application Support/Microsoft/Office365/User Content.localized/Startup.localized/Word/EndNote CWYW Word 16.bundle/Contents/Resources/English.lproj/EndNoteWebPreferencesDialog.nib
# /Library/Application Support/Microsoft/Office365/User Content.localized/Startup.localized/Word/EndNote CWYW Word 16.bundle/Contents/Resources/EndNote CWYW Word 16.dotm