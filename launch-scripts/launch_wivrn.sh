#!/bin/bash

### setup:

echo "-- Setting GPU mode to VR..."

# enable manual override
# https://lvra.gitlab.io/docs/performance/
# i use card1 here instead of card0, as my system is technically multi-GPU, though the iGPU doesn't work for some reason.
# the card0 directory doesn't even exist!
echo "manual" | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level

# translate "VR" into profile number
vr_profile=$(cat /sys/class/drm/card1/device/pp_power_profile_mode | grep ' VR ' | awk '{ print $1; }')

# set profile to VR
echo $vr_profile | sudo tee /sys/class/drm/card1/device/pp_power_profile_mode



# do other things here...

# this can also be done via the wivrn gui, but doing it here saves us a click
echo "-- Forwarding WiVRn port and launching the WiVRn app in wired mode on the HMD..."
adb reverse tcp:9757 tcp:9757
# uncomment one of these according to if you have the github or store version of wivrn installed on the headset
#adb shell am start -a android.intent.action.VIEW -d "wivrn+tcp://127.0.0.1" org.meumeu.wivrn
adb shell am start -a android.intent.action.VIEW -d "wivrn+tcp://127.0.0.1" org.meumeu.wivrn.github
echo "-- If the app doesn't launch on the headset and there is an error above, try uncommenting the other adb command instead."



### now launch wivrn


echo "-- Launching WiVRn from flatpak..."
flatpak run io.github.wivrn.wivrn

### once wivrn exits:

echo "-- Reverting GPU mode to Auto..."

# disable manual override
echo "auto" | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level

# set profile to DEFAULT
echo 0 | sudo tee /sys/class/drm/card1/device/pp_power_profile_mode
