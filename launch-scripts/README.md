# launch-scripts

The WiVRn script sets AMD GPU mode to VR, launches the Github WiVRn apk (org.meumeu.wivrn.github) on the headset, forwards the port to the device, launches WiVRn server from Flatpak, and then once WiVRn exits finally it sets the GPU mode back to Auto.
- Small note, I use `card1` for the GPU scripts since I technically use a multi-GPU system. Change all occurences to `card0` if that is the GPU you are running VR on.
