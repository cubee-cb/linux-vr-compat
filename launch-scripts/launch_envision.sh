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

#MONADO_SOCKET="/run/user/1000/monado_comp_ipc"
#echo "-- Removing $MONADO_SOCKET cause Envision doesn't like it existing..."
#rm $MONADO_SOCKET

echo "-- Launching Envision..."
#envision
~/Programs/envision/Envision-x86_64.AppImage

### once envision exits:

echo "-- Reverting GPU mode to Auto..."

# disable manual override
echo "auto" | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level

# set profile to DEFAULT
echo 0 | sudo tee /sys/class/drm/card1/device/pp_power_profile_mode
