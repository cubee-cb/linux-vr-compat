Testing VR games on my laptop, with CachyOS!
This is most certainly not a setup I will use often, but I do enjoy seeing what works.

## Current notes + small rants about... stuff.
- Performance in VR is utter rubbish.
  - This laptop's GPU dies under encoding load, so running VR with a standalone HMD is kind of a struggle.
    - It can't even manage 60 FPS. And stutters a fair bit... in Beat Saber of all things. At like 70% foveation, too.
  - So much for the "Extreme Performance" sticker that came stuck to it...
    - I get it's probably not intended to run both Encoding and 3D at the same time, but like, why not?
    - Was Windows lying about it having dedicated encoders? Or can Linux just not utilise them?
- There seems to be some hardware fault where the NVMe just... doesn't show up. (among various other, smaller faults; this is the big one though)
  - Not even the BIOS sees it in this state.
  - This means that, fairly frequently, *I can't even boot the laptop*. Gosh forbid companies make anything more than `instant e-waste` these days. It's hardly 3 years old.
    - Then sometimes when I try to boot off a USB instead it's like, *oh oopsie didn't see you there* and boots the NVMe instead.

### Shortcuts
- [Setup](#setup)
- [Working games](#working)

---

## Setup

---

### VR Hardware
- PICO 4 (256GB)
    - Typically used wired via USB-C. (UGREEN VR cable)
    - PICO Motion Trackers work about as well as they do.
    - Left controller seems to be failing now.
      - Keeps dropping out on occasion.
      - It's always the left controllers lol. My left WMR controller way back when was so power-hungry compared to the right.
- Quest 3s (128GB)
    - Typically used wired via USB-C. (Official Oculus Link cable)
    - Can be used in the dark, so if I want the lights off, this headset's the way to go.
- Common notes
    - Hand tracking works fine in titles that support it. Make sure it's enabled at the system level prior to launching WiVRn for the option to be available.
        - For PICO, this setting is under Settings > Lab > Hand Tracking.
    - Presence isn't passed through at this time, so VRChat doesn't trigger its AFK state for example.

### Laptop Hardware
- Lenovo "Yoga" Slim 7 ProX
  - *"Yoga" in quotes cause it doesn't even do the Yoga Thing(tm) where they fold over backwards... it's nothing more than a brand now.*
- AMD Ryzen 5 6600HS (Creator Edition, whatever that means)
- NVIDIA GeForce RTX 3050 Mobile (4GB) (RTX Studio variant, whatever that means)
- 16GB RAM (14GB Usable, 2GB for the AMD iGPU)
- Kingston 1TB NVMe

### Software
- CachyOS (KDE Plasma, X11)
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
