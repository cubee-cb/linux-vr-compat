Testing VR games on my laptop, with CachyOS!
This is most certainly not a setup I will use often, but I do enjoy seeing what works.

## Current notes:
- This laptop's GPU dies under encoding load, so running VR with a standalone HMD is kind of a struggle.
  - It hardly manages 60 FPS, if it even reaches that. And stutters a fair bit... in Beat Saber of all things.
  - So much for the "Extreme Ferformance" sticker that came stuck to it.

### Shortcuts
- [Setup](#setup)
- [Working games](#working)

---

## Setup

---

### Hardware
- Lenovo Yoga Slim 7 ProX
- AMD Ryzen 5 6600HS (Creator Edition, whatever that means)
- NVIDIA GeForce RTX 3050 Mobile (4GB) (RTX Studio variant, whatever that means)
- 16GB RAM (14GB Usable, 2GB for the AMD iGPU)
- Kingston 1TB NVMe
- PICO 4 headset, wired.
    - Hand tracking works fine in titles that support it. Make sure it's enabled at the system level prior to launching WiVRn for the option to be available. (Settings > Lab > Hand Tracking)
    - Presence sensor isn't passed through at this time, so VRChat doesn't trigger AFK, Vivecraft won't hotswitch, etc.

### Software
- CachyOS (KDE Plasma, Wayland for VR, X11 otherwise)
- [WiVRn](https://github.com/WiVRn/WiVRn) (Flatpak) set to use XRizer.
- [WlxOverlay-S](https://github.com/galister/wlx-overlay-s) for desktop views and playspace drag.
    - Space Drag is mapped to left/right stick click, Space Reset is mapped to double-click left stick.
- Most games run through Steam (non-Flatpak), SteamVR is not installed and shouldn't be except for very specific circumstances such as using its lighthouse driver.
- Proton: [GE-Proton9-27](https://github.com/GloriousEggroll/proton-ge-custom/releases/tag/GE-Proton9-27) (unless otherwise specified)

---

## Working
Things we can actually play! Yay!

^ - Using a different Proton version. (notes will mention why)

---

### ^ VRChat
- Testing GE-Proton10-15-rtsp18 (RTSP is the [recommended fork for VRChat](https://lvra.gitlab.io/docs/vrchat/#recommended-proton))
    - Formerly used GE-Proton9-20-rtsp16.
- Uses the following launch options based on [gamemoderun](https://github.com/FeralInteractive/gamemode):
    - `OXR_VIEWPORT_SCALE_PERCENTAGE=50 gamemoderun %command%`
    - This lowers the resolution cause rendering over 4Kx2K is pretty intensive.
- Full-body tracking (FBT):
  - Not implemented with vanilla XRizer at time of writing.

### ^ Beat Saber (Modded)
- Using Proton Experimental.
- Modding with [BSManager](https://github.com/Zagrios/bs-manager)
