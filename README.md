# linux-vr-compat
Testing VR games on my Linux setup with WiVRn and WlxOverlay.

Currently, WiVRn has incorrect controller offsets for PICO 4 controllers. Status on that is [as stated here](https://github.com/WiVRn/WiVRn/issues/94).

## Setup

### Software
- Fedora 41 (KDE Plasma, Wayland)
- WiVRN to connect to the headset and emulate SteamVR.
- WlxOverlay for desktops and playspace drag.
- Games run through Steam, SteamVR is not installed. Use launch arguments provided by WiVRn to run using WiVRn.
- Proton: GE-Proton9-18 (unless otherwise specified)

### Hardware
- AMD Ryzen 5 5600G
- AMD RX 6600XT 8GB
- 16GB RAM (2x8GB, 3200Mhz, DDR4)
- Everything installed on a hard drive. (including OS)
- PICO 4 headset, connected with USB 3.0.

## Working
- VRChat
    - World "Connecting" screens are broken.
    - Uses gamemoderun and custom start script from Linux VR Adventures Wiki. (EAC section)
- Beat Saber
    - Modding with Beat Saber Mod Manager. Settings and selected mods do not save.
    - Mods do not load with GE-Proton9-18, but do with Proton Experimental.
- Pistol Whip
    - First launch takes ages.
- The Lab
    - Loading screens are broken.
- Sushi Ben Demo

## Technically working
- Tea For God
    - Hands don't appear, so cannot interact with anything.
    - WiVRn doesn't provide a playspace, so only joystick locomotion is available.
- Resonite (Proton + Native)
    - Logged in, froze when loading cloud home while in the tutorial.
    - Desktop mode works.
    
## Non-working
- Ragnarock
    - Successfully launches in desktop mode without WiVRn.
    - When run with WiVRn, fails to launch with d3d11 error.
- Into the Radius
    - Successfully launches without WiVRn running.
    - When run with WiVRn, fails to launch with d3d11 error.
- Zenith VR
    - Loading screens are broken.
    - Crashes soon after launch with a texture error.
- Until You Fall
    - Black screen after logo, black-screen-fix beta no longer exists.
- Half-Life 2 VR
    - Launches, but can't find VR session

## Untested (but owned/willing to test)
- Rumble
- Hyper Dash
    - This also has a free standalone version on both PICO and Quest.
- Vacation Simulator
- VAIL
    - Uses Denuvo Anti-cheat, EAC for VRC is as far as I'm willing to go.
- ChilloutVR
- Down the Rabbit Hole
- Project Cars
- Propagation VR
- Museum of Other Realities
- Slinger VR
- I am Sakuya VR
- Aperture Hand Lab
- Desert Bus VR
- Republique VR
- Traffic Jams
