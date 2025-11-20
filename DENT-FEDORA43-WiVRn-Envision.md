Testing VR games with WiVRn and WlxOverlay-S on Fedora, using XRizer for SteamVR/OpenVR compatibility.

## Current notes:
- `amdgpu` resets not yet observed, but not known if resolved.

### Shortcuts
- [Setup](#setup)
- [Gotchas](#gotchas)
- [Working games](#working)
- [Partially working games](#partially-working)
- [Not working games](#not-working)
- [Development/hardware](#developmenthardware)

---

## Setup

---

### VR Hardware
- PICO 4 (256GB)
    - Typically used wireless.
    - PICO Motion Trackers work about as well as they do.
    - Left controller seems to be failing now.
      - Keeps dropping out on occasion.
      - It's always the left controllers lol. My left WMR controller way back when was so power-hungry compared to the right.
- Quest 3s (128GB)
    - Typically used wireless. I use this primarily for Beat Saber due to its higher refresh rate and presumably better controller prediction due to more sane offsets.
      - PICO 4 controllers are weird, man.
    - Can be used in the dark, so if I want the lights off, this headset's the way to go.
- Common notes
    - Hand tracking works fine in titles that support it. Make sure it's enabled at the system level prior to launching WiVRn for the option to be available.
        - For PICO, this setting is under Settings > Lab > Hand Tracking.
    - Presence isn't passed through at this time, so VRChat doesn't trigger its AFK state, Vivecraft won't hotswitch automatically, etc.

### PC Hardware
- AMD Ryzen 5 5600G (iGPU disabled)
- AMD Radeon RX 6600XT (8GB)
- 32GB RAM (2x16GB, 3600Mhz, DDR4)
- OS is on a SATA SSD.
- Most games installed on a hard drive, some on an extra NVMe I ended up with due to ongoing issues with Skittles (the laptop, not the snack).

### Software
- Fedora 43 (KDE Plasma, Wayland, initially installed as Fedora 41)
- [Envision](https://lvra.gitlab.io/docs/fossvr/envision/) - Handy tool to build my VR runtime stuff.
    - [WiVRn](https://github.com/WiVRn/WiVRn) - OpenXR runtime and streamer.
    - [XRizer](https://lvra.gitlab.io/docs/fossvr/xrizer/) - OpenVR > OpenXR compatibility layer. For full-body tracking, I use the following fork:
        - Repo: `https://github.com/ImSapphire/xrizer`
        - Branch: `generic_trackers`
- [WlxOverlay-S](https://github.com/galister/wlx-overlay-s) - An overlay application that provides desktop views and playspace drag.
    - My Space Drag is mapped to left/right stick click, while Space Reset is mapped to double-click left stick.
    - I also have WayVR Dashboard built and configured, but I don't have use for it at the current time.
- Most games run through Steam (non-Flatpak), SteamVR is not installed, and in this case shouldn't be.
- Default Proton: [GE-Proton9-18](https://github.com/GloriousEggroll/proton-ge-custom/releases/tag/GE-Proton9-18) (unless otherwise specified)

I will note that Envision is not typically recommended for WiVRn. Generally, you should be using system or Flatpak WiVRn instead. I will consider changing once either XRizer has FBT support properly built-in (Envision just makes building and using those forks practically seamless) or when Envision stops working.
Though, there are some benefits using Envision:
- I don't need to add the launch arguments to my Steam games.
- Using a different XRizer fork/branch is as simple as changing a URL and rebuilding.
- I get the latest changes as they happen without waiting for a release, though things might break sometimes.

---

## Gotchas
Some things to be careful of.

---

### Easy Effects
- This seems to cause WiVRn's audio to become crunchy. To work around, do one of the following:
    - Turn off the `Enable` toggle on the VR applications in the Output tab.
    - Disable its effect on audio outputs as a whole.
    - Close down Easy Effects completely.

### PROTON_LOG
- I learnt this the hard way; if you have added `PROTON_LOG=1` to your launch arguments, try not to forget.
  - My VRChat was unplayably laggy for weeks and I had no idea why until I went to the launch options to remove `--enable-debug-gui` and noticed it there from when I was debugging something.

---

## Working
Things we can actually play! Yay!

^ - Using a different Proton version. (notes will mention why)

---

### ^ VRChat
- UsingGE-Proton10-20-rtsp19 (RTSP is the [recommended fork for VRChat](https://lvra.gitlab.io/docs/vrchat/#recommended-proton))
- Uses the following launch options, including [gamemoderun](https://github.com/FeralInteractive/gamemode):
    - `gamemoderun %command% --enable-avpro-in-proton --disable-amd-stutter-workaround --enable-hw-video-decoding`
- World "Connecting" screen thumbnails' colours are just a bit off. Gamma issue? Wrong colour space?
- Full-body tracking (FBT):
  - Works fine with my chosen branch of XRizer.

#### [ToN Save Manager](https://github.com/ChrisFeline/ToNSaveManager) for Terrors of Nowhere (VRChat)
- I run this via [Protontricks](https://github.com/Matoking/protontricks) inside the VRChat prefix (appid 438100).
    - i.e. `flatpak run --command=protontricks-launch com.github.Matoking.protontricks --appid 438100 ./ToNSaveManager.exe`
    - Also, see this [launch script](vrchat/launch-ton-save-manager.sh) I made that works around a crash on launch.
- Seems to work fine. Finds save files in the logs, saves copy when clicked, and even OSC works.
  - You can test OSC with [Rin the Witch](https://vrchat.com/home/avatar/avtr_0ae41d3f-ae4a-437d-b429-4b1dbb217d20) from Spookality 2024. The gold on her outfit should change colour to match the Terror's colour shown in the wrist UI. Make sure OSC colour is set to HSV.

### ^ Beat Saber (Modded)
- Using Proton Experimental.
    - When I used Flatpak WiVRn, mods did not load with GE-Proton9-18.
- Modding with [BSManager](https://github.com/Zagrios/bs-manager).
    - If you want to use [Beat Saber Mod Manager](https://github.com/affederaffe/BeatSaberModManager) (which I still use for OneClick installation), settings and selected mods do not save on v0.0.6, so use v0.0.5 instead.

### ^ Resonite (Prerelease > .NET 10)
- Using GE-Proton10-15-rtsp18.
- .NET 10 breaks mods, so we'll have to wait for them to update. In my caase, my settings were broken (e.g. Motion Blur locked to 2000%) until I disabled the modloader.
- Full-body tracking (FBT):
  - Trackers appear fine with my chosen branch of XRizer.

---

## Partially working
These launch, but are unplayable or have issues functioning.
Or, in some cases they started working all of a sudden but I have no idea why.

---

None tested.

---

## Not working
The following crash on launch or have other major issues.

---

### [Whimsy](https://peopleofwhimsy.itch.io/whimsy) (totally not biased)
- Unity Player fails to launch, seemingly regardless of the Proton version used.
    - Proton logs output `unhandled page fault`.
    - Player logs output `Failed to create the D3D11 device`.
    - Some versions of Proton additionally specify the following in the Player log:
        - `Got a UNKNOWN while executing native code. This usually indicates a fatal error in the mono runtime or one of the native libraries used by your application.`

---

## Development/hardware
Troubleshooting setup of hardware or build issues.

---

### Envision WiVRn Setup
- Envision's WiVRn build used to fail with what looks like an error in the code itself. After several months, a variety of system upgrades, installing packages to build WiVRn standalone, and updating `rustup`, the Envision build works now! idk why. Whatever, I'm happy.
- Optionally set up WiVRn, XRizer, etc as described in the Software section at the top.
- Clean build!

### ALCOM ([vrc-get-gui](https://github.com/vrc-get/vrc-get/blob/master/vrc-get-gui/README.md))
- Alternative Creator Companion for VRChat.
- The AppImages display a white screen on launch, so building ALCOM manually is pretty much required on this system.
    - EGL Display error. Basically identical to [this comment](https://github.com/vrc-get/vrc-get/issues/1694#issuecomment-2480857765) on the white screen issue thread.
- Needed to install DNF packages `nodejs-npm gtk3-devel libsoup3-devel javascriptcoregtk4.1-devel webkit2gtk4.1-devel dotnet-sdk-8.0` and cargo crate `cargo-about`.
- Final step of build fails to bundle the AppImage. The raw executable is built in `vrc-get/target/release/` anyway.
    - As long as it says `Built application at: /home/user/.../vrc-get/target/release/ALCOM` you should be all good.
    - Might break some things if it expects to be running as an AppImage, for example the setting `Use ALCOM for vcc: URL Scheme` shows a "failed to get appimage path" error, more remains to be seen.
- As for Unity Hub itself:
    - Launching the Flatpak version of Unity Hub though ALCOM fails with a "No valid license found" error, no matter which variant of ALCOM I use.
    - Using the Unity Hub binary from the yum repo provided by Unity seems to work fine.

---
