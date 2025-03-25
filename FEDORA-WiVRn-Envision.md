Testing VR games with WiVRn and WlxOverlay-S on Fedora, using XRizer.

### Shortcuts
- [Setup](#setup)
- [Working games](#working)
- [Partially working games](#partially-working)
- [Not working games](#not-working)
- [Development/hardware](#developmenthardware)
- [Curiosities](#curiosities)
- [Untested](#untested)

---

## Setup

---

### Hardware
- AMD Ryzen 5 5600G
- AMD RX 6600XT 8GB
- 16GB RAM (2x8GB, 3200Mhz, DDR4)
- OS is on an SSD.
- Most games installed on a hard drive.
- PICO 4 headset, wireless.
    - Hand tracking works fine in titles that support it. Make sure it's enabled at the system level prior to launching WiVRn for the option to be available. (Settings > Lab > Hand Tracking)
    - Presence sensor isn't used, so VRChat doesn't trigger AFK, Vivecraft won't hotswitch, etc.

### Software
- Fedora 41 (KDE Plasma, Wayland)
- The following runtime setup:
    - [Envision] with latest [WiVRn](https://github.com/WiVRn/WiVRn), using XRizer for OpenVR titles.
        - Plus WlxOverlay-S and WayVR Dashboard.
- [WlxOverlay-S](https://github.com/galister/wlx-overlay-s) for desktop views and playspace drag.
    - Space Drag is either left/right stick click, Space Reset is double-click left stick.
- Most games run through Steam (Runtime), SteamVR is not installed.
- Proton: [GE-Proton9-18](https://github.com/GloriousEggroll/proton-ge-custom/releases/tag/GE-Proton9-18) (unless otherwise specified)

---

## Working
Things we can actually play! Yay!

^ - Using a different Proton version. (notes will mention why)

---

### ^ VRChat
- Using GE-Proton9-20-rtsp16 since it's the [recommended fork for VRChat](https://lvra.gitlab.io/docs/vrchat/#recommended-proton). GE-Proton9-18 works fine otherwise.
- World "Connecting" screens are slightly broken, but overall look mostly like they are intended to, unlike in OpenComposite.
  - The world images are just a little desaturated + a couple other small visual quirks. (much better than a black void with broken image planes, lol)
- Uses [gamemoderun](https://github.com/FeralInteractive/gamemode) and custom start script from [Linux VR Adventures Wiki](https://lvra.gitlab.io/docs/vrchat/eac/).
    - idk if the start script helps much though.
- Terrors of Nowhere
    - [ToN Save Manager](https://github.com/ChrisFeline/ToNSaveManager) runs via [Protontricks](https://github.com/Matoking/protontricks) inside the VRChat prefix (appid 438100).
        - See [the VRChat folder](vrchat/launch-ton-save-manager.sh) for an example launch script using flatpak Protontricks.
        - Seems to work fine. Finds save files in the logs, saves copy when clicked, and even OSC works.
            - You can test OSC with [Rin the Witch](https://vrchat.com/home/avatar/avtr_0ae41d3f-ae4a-437d-b429-4b1dbb217d20) from Spookality 2024. The gold on her outfit should change colour to match the Terror's colour shown in the UI. Make sure the OSC colour setting is enabled and set to HSV colours.
- Sometimes launching in VR bombards me with Anti-Cheat errors, despite using the start script. These errors actually have text though, saying the files failed to verify, and may also be related to the system being overloaded while starting. Perhaps this was due to a HDD bottleneck, notably this hasn't yet occured since moving my OS and VRChat to an SSD.
- Some videos (non-16:9?) don't display at all and cause my world's video player to display the Audio Only image, while on PICO Standalone and Windows they show a letterboxed image.
    - Exhibited on ProTV 3 in [my home world](https://vrchat.com/home/launch?worldId=wrld_f79b0387-d681-409a-bbe8-4a40cc8528ce).

### ^ Beat Saber (Modded)
- Modding with [Beat Saber Mod Manager](https://github.com/affederaffe/BeatSaberModManager).
    - Settings and selected mods do not save on v0.0.6, use v0.0.5 instead.
- Using Proton Experimental.
    - Based on testing with Flatpak WiVRn, mods do not load with GE-Proton9-18.

### ^? Until You Fall ([Video](https://youtu.be/ESWKezEggIg&t=1975))
- IT WORKS???? What? Yeah using XRizer gets it past the black screen and is somehow playable.
- Major performance issues, eventually got nearly to a complete stop and almost locked up the system. Maybe not specifically the game's fault? Too much RAM used? Needs testing.
- Using GE-Proton7-55, unsure if other versions work.

### ChilloutVR
- No notable issues after a short run around my home world. Haven't yet tested joining a live instance.

## Partially working
These launch, but are unplayable or have serious issues functioning.
Or, in some cases they start working all of a sudden but I have no idea why.

---

### ^ Resonite (Proton, [see here](https://lvra.gitlab.io/docs/resonite/))
- Displays a black screen on the HMD.
- In the desktop view, the HMD is tracked but no hands are visible.

---

## Not working
The following crash on launch or have other major issues.

---

### Vivecraft
- Running through Prism Launcher (Flatpak), with Vivecraft 1.21.1-1.2.2-fabric on Quilt Loader.
- Fails to enter VR mode.

### GRIP
- On entering VR mode, the following XRizer error appears: `src/system.rs:209:9: not yet implemented`
- Some extra notes:
    - HMD view only. Requires a standard controller/wheel.
    - Splash screens are displayed on the desktop, but once in the game menus it switches to VR.
    - Desktop mode seems to work.

### Desert Bus VR
- Launches in desktop mode even when choosing the SteamVR launch option.

### The Forest
- The following XRizer error appears: `src/graphics_backends.rs:122:22: Unsupported texture type: DirectX`

### I am Sakuya VR
- Seems to launch in desktop mode? Or at least without the VR view.

---

## Development/hardware
Troubleshooting setup of hardware or build issues.

---

### WlxOverlay-S
- Once all the dependencies were installed, no issues.
  - Been contributing a few things since I wrote this and still no problems.

### Envision WiVRn Setup
- Envision's WiVRn build used to fail with what looks like an error in the code itself. After several months, a variety of system upgrades, installing packages to build WiVRn standalone, and updating `rustup`, the Envision build works now! idk why. Whatever, I'm happy.
- Set one of the following (be wary of if these change in the future):
    - Rin's experimental XRizer branch (the one I'm using):
        - OpenVR Module Type: `xrizer`
        - OpenVR Compatibility Repo: `https://github.com/RinLovesYou/xrizer`
        - OpenVR Compatibility Branch: `experimental`
    - Base XRizer (I haven't tried this yet):
        - OpenVR Module Type: `xrizer`
        - OpenVR Compatibility Repo: `https://github.com/Supreeeme/xrizer`
        - OpenVR Compatibility Branch: `main`
- Clean build!

### ALCOM ([vrc-get-gui](https://github.com/vrc-get/vrc-get/blob/master/vrc-get-gui/README.md))
- Alternative Creator Companion for VRChat.
- The AppImages display a white screen on launch. Initially v0.1.15 worked, but some system upgrade must have broken it. v0.1.16 never worked.
    - EGL Display error. Basically identical to [this comment](https://github.com/vrc-get/vrc-get/issues/1694#issuecomment-2480857765) on the white screen issue thread.
- Needed to install DNF packages `nodejs-npm gtk3-devel libsoup3-devel javascriptcoregtk4.1-devel webkit2gtk4.1-devel dotnet-sdk-8.0` and cargo crate `cargo-about`.
- Final step of build fails to bundle the AppImage. The raw executable is built in `vrc-get/target/release/` anyway.
    - As long as it says `Built application at: /home/user/.../vrc-get/target/release/ALCOM` you should be all good.
    - Might break some things if it expects to be running as an AppImage, for example the setting `Use ALCOM for vcc: URL Scheme` shows a "failed to get appimage path" error, more remains to be seen.
- As for Unity Hub itself:
    - Launching the Flatpak version of Unity Hub though ALCOM fails with a "No valid license found" error, no matter which variant of ALCOM I use.
    - Using the Unity Hub binary from the yum repo provided by Unity seems to work fine, so this is now a functioning setup.
        - However, I still prefer to Moonlight into my Windows laptop for Unity stuff due to general Unity-Wayland quirks. I've got Godot here anyway (which has functional OpenXR builds for Linux, unlike Unity :DD).

---

## Curiosities
Stuff I don't expect to work but try anyway, because why not? Maybe something interesting will happen.

---

### Nothing here yet!

---

## Untested
Owned and/or willing to test.
May have been tested in past setups. If something's untested here, maybe check the list for Flatpak WiVRn?

---

### Pistol Whip

### VAIL

### Rec Room

### ^ Ragnarock
- Successfully launches with GE-Proton7-55. Fails to launch with D3D11 error on GE-Proton9-18.

### ^ Into the Radius
- Successfully launches with GE-Proton7-55. Fails to launch with D3D11 error on GE-Proton9-18.

### Hellblade: Senua's Sacrifice VR Edition

### Catlateral Damage VR

### The Lab

### Rumble

### Keep Talking and Nobody Explodes
- Linux native doesn't support VR, use Proton instead.

### Vertigo: Remastered

### Vacation Simulator ([Video](https://youtu.be/ESWKezEggIg&t=1470))

### SUPERHOT VR (Pre-removed scenes version via depot download)

### Sushi Ben Demo ([Video](https://youtu.be/TEen2J73evQ?t=1284))

### Down the Rabbit Hole

### Propagation VR

### [Beat Saber Origins](https://hyperbolicmagnetism.itch.io/beat-saber-origins)

### ^ Kart Racing Pro rel13e (Non-Steam version)

### Zenith VR

### Half-Life 2 VR

### Project Cars

### Hyper Dash

### Legend of Dungeon

### Museum of Other Realities

### Garry's Mod VR Mod

### Half Life: Alyx

### Assetto Corsa

### COMPOUND Demo

### Metal: Hellsinger VR Demo

### Tea For God

### Aperture Hand Lab

### Kingspray Graffiti

### Slinger VR

### Tabletop Simulator
