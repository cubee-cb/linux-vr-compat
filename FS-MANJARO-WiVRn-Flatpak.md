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
    - Typically used wireless.

### PC Hardware
- AMD Ryzen 5 5600G
- Integrated GPU (16GB VRAM)
- 64GB RAM (?MHz, DDR4)
  - just... why? on this system?
- OS is on a SATA SSD.
- Most games installed with a hard drive-backed SSD cache.

### PC Software
- Distro: Manjaro
- Desktop: ?, X11
- Steam: native package (i.e. not the flatpak)
- Proton: idk
- XR Stack:
      - [WiVRn (Flatpak)](https://github.com/WiVRn/WiVRn) - Monado-based OpenXR runtime and streamer for Standalone HMDs.
      - [XRizer](https://lvra.gitlab.io/docs/fossvr/xrizer/) - OpenVR > OpenXR compatibility layer.
    - SteamVR is *not* installed, and in most cases shouldn't be as it can conflict with WiVRn.

---

## Working
Things we can actually play! Yay! There may be small issues here and there but these are not typically game-breaking.

^ - Using a different Proton version. (notes will mention why)

---

### ^ Beat Saber (1.40.8 Modded)
- Using Proton Experimental.
- Launch Options: `OXR_VIEWPORT_SCALE_PRECENTAGE=50 %command%`
  - Lowers resolution so as to not kill the poor iGPU.
- Mod install copied from Dent.
