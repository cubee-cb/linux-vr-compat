Testing VR games with Flatpak WiVRn on Manjaro.

If a game isn't listed here, check out the other files to see if I've tried it elsewhere.

### Shortcuts
- [Setup](#setup)
- [Working games](#working)

---

## Setup

---

### VR Hardware
- PICO 4 (256GB)
    - Wired via USB A-C cable. (PC has no USB-C)

### PC Hardware
- AMD Ryzen 5 5600G
- Integrated GPU (Allocated 16GB? VRAM)
- 64GB RAM (48GB usable, ?MHz, DDR4)
  - just... why? on this system?
- OS is on a SATA SSD.
- Most games installed with a hard drive-backed SSD cache.

### PC Software
- Distro: Manjaro
- Desktop: ?, X11
- Steam: native package (i.e. not the flatpak)
    - All Launch Options should be combined with the ones specified by WiVRn.
- Proton: idk, will be noted per-game.
- XR Stack:
      - [WiVRn (Flatpak)](https://github.com/WiVRn/WiVRn) - Monado-based OpenXR runtime and streamer for Standalone HMDs.
      - [XRizer](https://lvra.gitlab.io/docs/fossvr/xrizer/) - OpenVR > OpenXR compatibility layer.
    - SteamVR is *not* installed, and in most cases shouldn't be as it can conflict with WiVRn.

---

## Working
Things we can actually play! Yay! There may be small issues here and there but these are not typically game-breaking.

^ - Using a different Proton version. (notes will mention why)

---

### Beat Saber (1.40.8 Modded)
- Using Proton Experimental.
- Launch Options: `OXR_VIEWPORT_SCALE_PRECENTAGE=50 %command%`
  - Lowers resolution so as to not kill the poor iGPU.
- Mod install copied from Dent.

### Keep Talking and Nobody Explodes (Proton)
- Proton: GE-Proton7? a few versions worked, though.
- Launch Options: `OXR_VIEWPORT_SCALE_PRECENTAGE=75 %command%`
- Native Linux build doesn't support VR due to Unity shenanigans.
- There was a screen tearing effect in the right eye only.
    - Had to turn down WiVRn resolution to 120% (from 140%). Issue was not present in Beat Saber, oddly.
