Testing VR games with WiVRn and WlxOverlay-S on Fedora, using XRizer for SteamVR/OpenVR compatibility.

## Current notes:
- Occasional `amdgpu` resets occur.
- Recently my setup has developed screen "tearing", mostly in high-intensity scenes. No idea why. Very distracting.
- I need to re-test a lot of these games with newer updates to XRizer.


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
- 32GB RAM (2x16GB, 3600Mhz, DDR4)
- OS is on a SATA SSD.
- Most games installed on a hard drive.
- PICO 4 headset, wireless.
    - Hand tracking works fine in titles that support it. Make sure it's enabled at the system level prior to launching WiVRn for the option to be available. (Settings > Lab > Hand Tracking)
    - Presence sensor isn't passed through at this time, so VRChat doesn't trigger AFK, Vivecraft won't hotswitch, etc.
    - PICO Motion Trackers work about as well as they should.

### Software
- Fedora 42 (KDE Plasma, Wayland, upgraded from Fedora 41)
- [Envision](https://lvra.gitlab.io/docs/fossvr/envision/)
    - [WiVRn](https://github.com/WiVRn/WiVRn) - 
    - [XRizer](https://lvra.gitlab.io/docs/fossvr/xrizer/) - For using PICO Motion Trackers in Resonite and such, I use the following fork:
        - Repo: `https://github.com/Mr-Zero88-FBT/xrizer`
        - Branch: `experimental2`
        - Typically one would use the [fork by RinLovesYou](https://github.com/RinLovesYou/xrizer/tree/experimental2), I forget why I use this one but it had something to do with Resonite at the time.
- [WlxOverlay-S](https://github.com/galister/wlx-overlay-s) for desktop views and playspace drag.
    - Space Drag is mapped to left/right stick click, Space Reset is mapped to double-click left stick.
    - I also have WayVR Dashboard configured, but I don't use it.
- Most games run through Steam (non-Flatpak), SteamVR is not installed and shouldn't be except for very specific circumstances such as using its lighthouse driver.
- Proton: [GE-Proton9-18](https://github.com/GloriousEggroll/proton-ge-custom/releases/tag/GE-Proton9-18) (unless otherwise specified)

I am aware that Envision is no longer recommended for WiVRn, and that I should be using Flatpak WiVRn instead. I will change back once either XRizer has FBT support properly built-in (Envision just makes building and using those forks practically seamless) or when Envision stops working.
Benefits this way:
- I don't need launch arguments in my Steam games.
- Using a different XRizer fork/branch is as simple as changing a URL and rebuilding.
- I get the latest changes as they happen without waiting for a release, though it might break things sometimes.

---

## Working
Things we can actually play! Yay!

^ - Using a different Proton version. (notes will mention why)

---

### ^ VRChat
- Testing GE-Proton10-15-rtsp18 (RTSP is the [recommended fork for VRChat](https://lvra.gitlab.io/docs/vrchat/#recommended-proton))
    - Formerly used GE-Proton9-20-rtsp16.
- Uses the following launch options based on [gamemoderun](https://github.com/FeralInteractive/gamemode):
    - `gamemoderun %command% --enable-avpro-in-proton --disable-amd-stutter-workaround --enable-hw-video-decoding --enable-debug-gui`
    - I have world debug GUIs on since I make worlds and I think they're neat to have.
- World "Connecting" screen thumbnails' colours are just a bit off. Gamma issue? Wrong colour space?
- Some videos display incorrectly, distorted as if skewed to one side with broken colours.
    - Exhibited on ProTV 3 in [my home world](https://vrchat.com/home/launch?worldId=wrld_f79b0387-d681-409a-bbe8-4a40cc8528ce).
    - Specifically [Geoxor Epic Playlist](https://www.youtube.com/watch?v=muJ8ZL7a4SY), which on Proton9-RTSP didn't display at all.
    - It's not necessarily an Aspect Ratio thing, as other 16:9, 1:1, and 16:10 videos I tested work fine.
- Full-body tracking (FBT):
  - Works fine with my chosen branch of XRizer.

### [ToN Save Manager](https://github.com/ChrisFeline/ToNSaveManager) for Terrors of Nowhere (VRChat)
- I run this via [Protontricks](https://github.com/Matoking/protontricks) inside the VRChat prefix (appid 438100).
    - i.e. `flatpak run --command=protontricks-launch com.github.Matoking.protontricks --appid 438100 ./ToNSaveManager.exe`
    - Also, see this [launch script](vrchat/launch-ton-save-manager.sh) I made that works around a crash on launch.
- Seems to work fine. Finds save files in the logs, saves copy when clicked, and even OSC works.
  - You can test OSC with [Rin the Witch](https://vrchat.com/home/avatar/avtr_0ae41d3f-ae4a-437d-b429-4b1dbb217d20) from Spookality 2024. The gold on her outfit should change colour to match the Terror's colour shown in the wrist UI. Make sure OSC colour is set to HSV.

### ^ Resonite (Proton, Pure Native is deprecated and for now as of The Splittening is replaced with a hybrid setup launched via Proton)
- Testing GE-Proton10-15-rtsp18. Wy "default" Proton version works fine otherwise.
- Haven't looked back into modding since The Splittening.
- Full-body tracking (FBT):
  - Works fine with my chosen branch of XRizer.

### ^ Beat Saber (Modded)
- Using Proton Experimental.
    - When I used Flatpak WiVRn, mods did not load with GE-Proton9-18.
- Modding with [BSManager](https://github.com/Zagrios/bs-manager), formerly [Beat Saber Mod Manager](https://github.com/affederaffe/BeatSaberModManager) v0.0.5 (still used for OneClick as I haven't figured out why BSManager didn't work for that yet)
    - If you use Beat Saber Mod Manager, settings and selected mods do not save on v0.0.6, so use v0.0.5 instead.

### Pistol Whip
- Nothing of note. It just works.

### ^ Until You Fall
- Using GE-Proton7-55, unsure if other versions work.
- With XRizer, this gets past the black screen and is somehow playable. Occasional crash on launch that should be fixed on the latest commits or XRizer.
- Some performance issues, first run eventually got nearly to a complete stop and almost locked up the system. Maybe not specifically the game's fault? Too much RAM used? Needs testing.

### ChilloutVR
- No issues related to this setup.
    - There was a voice server problems I heard about in an instance I joined, around September 2025, but as said, server issue. Not WiVRn-, XRizer- or Linux-related.
- Full-body tracking (FBT):
  - Works mostly fine with my chosen branch of XRizer. Some quirks with the body being pulled along with the legs sometimes, probably due to the platform's IK setup or my settings.
  - Touching the ground with most avatars puts them in a "crouch" pose or flickers rapidly between standing and "crouching".
      - Avatars that are playspaced above the ground or have Locomotion disabled seem to behave as expected.

### Vivecraft
- Running through Prism Launcher, with Vivecraft 1.21.1-1.2.5-fabric on Fabric Loader.
    - The Flatpak version of Prism requires you to cast some spells for it to work with Envision. Grant the following file access permissions via your favourite method (mine is Flatseal):
        - `xdg-config/openxr:ro`
        - `xdg-config/openvr:ro`
        - `~/.local/share/envision:ro`
        - `xdg-run/wivrn/comp_ipc:rw` (maybe only required for WiVRn)
        - `xdg-run/monado_comp_ipc:rw` (maybe only required for Monado)
        - [Image from the LVRA Discord](https://discord.com/channels/1065291958328758352/1225819663024259082/1369754980457648148) + context.
        - If you store some of your mod data outside the instance, don't forget to ensure those paths are here too.
            - I accidentally removed mine, causing Distant Horizons and Figura to be unable to access their data, which broke things in a rather dramatic fashion.
- Full-body tracking (FBT):
    - Works fine with my chosen branch of XRizer.
    - (todo: re-test with current setup) Using SlimeVR OSC trackers seems to work at first, but calibrating results in all parts being locked to the head.
        - Perhaps Vivecraft will not calibrate to OSC trackers if any native trackers exist, despite being "inactive"?
- Rebinding controls:
    - Place the `xrizer`/`OpenComposite` directory in the instance's `minecraft` folder. (next to `options.txt`)
    - Default bindings are in the `minecraft/openvr` folder, or you can try to find your SteamVR bindings somewhere inside SteamVR's workshop folder.
    - Then you can follow [the LVRA Wiki](https://lvra.gitlab.io/docs/fossvr/opencomposite/#rebinding-controls) as usual.
        - Make sure the binding files are named without spaces and underscores, so a config for `oculus_touch` becomes `oculustouch.json`.
    - Alternatively, I have made [a guide of sorts on my website](https://cubee.games/wiki/?cat=guides&page=steamvr#extract-bindings).

### COMPOUND Demo
- Nothing of note. It just works.

### ^ Half-Life: Alyx (Proton)
- Using Proton Experimental.
- Controls work properly now! Yay!
- Lower than expected performance.
    - This *probably* is due to the new headset, back on Windows 10 I used Windows Mixed Reality at 1440^2 per eye, while here I have 2160^2 per eye. (over double the amount of pixels!)
- Obnoxiously slow load times on an HDD. Might move it to the NVMe I stole from my laptop.

## Partially working
These launch, but are unplayable or have issues functioning.
Or, in some cases they started working all of a sudden but I have no idea why.

---

### Tea For God
- The hands are visible, unlike OpenComposite, and as such the game is mostly playable.
- Entering the options menu crashes the game with a `not implemented` error in `chaperone.rs`.
- Some notes:
    - There is no playspace, at least not with the PICO 4, so using roomscale motion defaults the world to a tiny 2x3 grid with a massive movement multiplier.
        - I can navigate the entire world just by leaning, kinda funny.
        - Joystick locomotion is likely more viable, until the options menu works.

### VAIL
- Trigger touch is mapped to trigger full press. Touching the trigger fires the weapons, presses the menu, etc. Playable otherwise.

### Rumble
- Hands point upward, making the earthbending quite difficult to perform. Works otherwise.

---

## Not working
The following crash on launch or have other major issues.

---

### GRIP
- On entering VR mode, the following XRizer error appears:
    - First test: `src/system.rs:209:9: not yet implemented`
    - April 2025 test: `compositor.rs .. pose invalid`
- Some extra notes:
    - HMD view only. Requires a standard controller/wheel.
    - Splash screens are displayed on the desktop, but once in the game menus it switches to VR.
    - Desktop mode seems to work.

### Desert Bus VR
- Launches in desktop mode even when choosing the SteamVR launch option.

### The Forest
- The following XRizer error appears: `src/graphics_backends.rs:122:22: Unsupported texture type: DirectX`

### I am Sakuya VR
- Does not launch in VR. Desktop window is controllable with standard controls, but the camera and hand are stuck in place.

### Catlateral Damage VR
- Does not launch in VR. Desktop window appears and shows blue overlays on the objects. (iirc this happens when the player is inside objects or teleporting?)

---

## Development/hardware
Troubleshooting setup of hardware or build issues.

---

### WlxOverlay-S
- Once all the dependencies were installed, no issues.
  - Been contributing a few things since I wrote this and still no problems other than having to install any added dependencies.

### Envision WiVRn Setup
- Envision's WiVRn build used to fail with what looks like an error in the code itself. After several months, a variety of system upgrades, installing packages to build WiVRn standalone, and updating `rustup`, the Envision build works now! idk why. Whatever, I'm happy.
- Optionally set up WiVRn, XRizer, etc as described in the Software section at the top.
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
        - Previously, I used Sunshine and Moonlight to remote to a Windows laptop for Unity work, but I edned up putting Arch (CachyOS btw) on that so now I do all my work on my PC.

---

## Curiosities
Stuff I don't expect to work but try anyway, because why not? Maybe something interesting will happen.

---

### Nothing here yet!
- I tried a couple things on Fedora 41 with Flatpak WiVRn, maybe go check out that file if you're curious.

---

## Untested
Owned and/or willing to test.
May have been tested in past setups. If something's untested here, maybe check the file for Flatpak WiVRn?

---

### Rec Room

### ^ Ragnarock
- Successfully launches with GE-Proton7-55. Fails to launch with D3D11 error on GE-Proton9-18.

### ^ Into the Radius
- Successfully launches with GE-Proton7-55. Fails to launch with D3D11 error on GE-Proton9-18.

### Hellblade: Senua's Sacrifice VR Edition

### Catlateral Damage VR

### The Lab

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

### Assetto Corsa

### COMPOUND Demo

### Metal: Hellsinger VR Demo

### Tea For God

### Aperture Hand Lab

### Kingspray Graffiti

### Slinger VR

### Tabletop Simulator
