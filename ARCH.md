Testing VR games with WiVRn and WlxOverlay-S on Arch Linux. ~And guess what? My GPU doesn't crash here!~

Uh nevermind. It crashes now. Hope it's not a hardware issue, which it will be now I've written this down. Or will it? I love uncertainty.
Also the SSD doesn't boot anymore so I might have to work out what's going on there. Or just reroll the system on a new drive like I kind of want to do anyway, and consolidate my Fedora dev/gaming setup and Arch VR setup into the one install. `dnf` is sloooowwwwww. I'm liking `pacman` and `yay` so far. I guess I use Arch now? Just `archinstall` so it's not "proper" but frankly I don't care how it's installed as long as my distro functions.

### Shortcuts
- [Setup](#setup)
- [Working games](#working)
- [Partially working games](#partially-working)
- [Not working games](#not-working)
- [Development](#development)

---

## Setup

---

### Hardware
- AMD Ryzen 5 5600G
- AMD RX 6600XT 8GB
- 16GB RAM (2x8GB, 3200Mhz, DDR4)
- Storage: 60GB OCZ-Vertex SSD from like 2011 that's somehow still kicking, plugged into a USB 3 hub. (watch it stop working now i've written that. ...AYYY I called it! yeah it won't boot. can still access the files though.)
- PICO 4 headset, wireless.
    - ~Currently, I still have incorrect controller offsets for PICO 4 controllers. Supposedly it was fixed in WiVRn v0.22, and indeed they look correct in the WiVRn client menu and WlxOverlay-S, but they still have the wrong offsets in OpenComposite applications.~ Some OpenComposite games' offsets are still incorrect, i.e. Beat Saber.
    - Something is causing the USB mode to disconnect constantly, will need to figure that out at some point since I prefer using the cable for stability.
    - Hand tracking works fine in titles that support it. Make sure it's enabled at the system level to turn it on in WiVRn. (Settings > Lab > Hand Tracking)
    - Presence sensor isn't used, so VRChat doesn't trigger AFK, Vivecraft won't hotswitch, etc.

### Software
- Vanilla Arch Linux (KDE Plasma Desktop, Wayland)
    - Initially installed with Hyprland so I could try it, not a fan of having to constantly hit Super to do anything. Replaced it with barebones KDE Plasma (no KDE apps).
    - Installed Niri to try but there's no environment over it so it doesn't really work lol.
- [WiVRn](https://github.com/WiVRn/WiVRn) (v0.23, SolarXR branch) to connect to the PICO 4 and emulate SteamVR via OpenComposite.
- [Envision](https://gitlab.com/gabmus/envision).
    - Hey, it actually works on Arch! Go figure.
    - Start script that handles setting the GPU mode to VR while Envision is running.
- [WlxOverlay-S](https://github.com/galister/wlx-overlay-s) for desktop views and playspace drag.
    - Working Set Toggle is Menu, Space Drag is left/right stick click, Space Reset is double-click left stick.
    - Framerate drops when playing heavier VRChat worlds. Unsure why as this doesn't happen on Fedora under most similar circumstances.
- Most games run through Steam (Runtime), SteamVR is not installed. Envision does some magic to make games use it as the VR runtime.
- Proton: [GE-Proton-9-25](https://github.com/GloriousEggroll/proton-ge-custom), unless otherwise specified.

---

## Working
Things we can actually play! Yay!

^ - Using a different Proton version. (notes will mention why)

---

### ^ VRChat
- Using to GE-Proton9-22-rtsp17. Regular GE-Proton also works.
- World "Connecting" screens are broken, known OpenComposite quirk.

### Beat Saber

### Pistol Whip
- First launch took ages, but otherwise works perfectly.

### SUPERHOT VR
- Seemingly much better throwing in this verison of WiVRn.

---

## Partially working
These launch, but are unplayable or have serious issues functioning.
Or, in some cases they start working all of a sudden but I have no idea why.

---

### Tea For God
- Hands don't appear, so cannot interact with anything.
- This setup doesn't provide a playspace at all, so only joystick locomotion is available.
    - Maybe [LOVR Playspace](https://lvra.gitlab.io/docs/fossvr/lovr/lovr-playspace/) could help with this, if it actually creates a playspace and isn't just visual.

---

## Not working
The following crash on launch or have other major issues.

---



---

## Development
Troubleshooting build issues.

---

### Envision WiVRn (SolarXR branch)
- Build works perfectly after running the `pacman` command to install dependencies.

### Envision WMR (Controller Tracking branch)
- Build works perfectly after running the `pacman` command to install dependencies.
- Controller tracking branch works, but my controllers aren't tracked. They don't light up enough to be seen by the constellation tracker and/or aren't even detected at all?

### SlimeVR (for SolarXR integration with WiVRn)
- Installed from AUR via `yay`. (`server` and `gui`, numbered 4 and 5 for me)
- GUI installs fine.
- Server fails to build due to Gradle not finding Java 17 despite `jdk17` being installed.
  - Might just wait for the release that includes SolarXR, not too fussed using OSC since I use Joy-Cons with skating correction off anyway.

---

