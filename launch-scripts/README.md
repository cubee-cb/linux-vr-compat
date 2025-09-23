# launch-scripts

Small note, I use `card1` for the GPU scripts since I technically use a multi-GPU system due to having an iGPU, despite it being disabled in the BIOS.
Change all occurences to `card0` if that is the GPU you are running VR on.

- The WiVRn script is set up for running over USB. It does the following:
  - Sets the AMD GPU mode to VR.
  - Launches the GitHub version of the WiVRn Client APK (org.meumeu.wivrn.github) over ADB.
  - Forwards the port to the device.
  - Launches the WiVRn Server Flatpak.
  - Once WiVRn exits, finally sets the GPU mode back to Auto.
- The Envision script:
  - Sets the AMD GPU mode to VR.
  - Launches Envision.
  - Once Envision exits, finally sets the GPU mode back to Auto.
