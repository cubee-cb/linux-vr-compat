#!/bin/bash

# give instant feedback since launching takes some time.
notify-send "Starting ToN Save Manager"

cd ~/Programs/ToNSaveManager/

# suddenly started crashing on launch. was trying to access the following:
# `[Z:\\home\\curin\\Programs\\ToNSaveManager\\/home/curin/.cache/dotnet_bundle_extract\\]`
# i changed this so it goes to `Z:\home\curin\Programs\ToNSaveManager\dotnet_bundle\` instead.
export DOTNET_BUNDLE_EXTRACT_BASE_DIR=dotnet_bundle
# i presume something changed, and now the env var is treated as relative instead of absolute.

# launch save manager using protontricks under the vrchat prefix
flatpak run --command=protontricks-launch com.github.Matoking.protontricks --appid 438100 ./ToNSaveManager.exe

# clean up, since it makes a new folder for each update.
# probably should check if "*.exe.old" exists but can't be bothered atm.
rm -r dotnet_bundle

notify-send "ToN Save Manager has exited"
