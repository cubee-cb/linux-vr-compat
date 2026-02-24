Testing VR games with WiVRn and WayVR on Fedora, using XRizer for SteamVR/OpenVR compatibility.

Since WiVRn is being removed from Envision, I finally have an excuse to move away from it and make my XR stack more automated myself.

If a game isn't listed here, check out the other files to see if I've tried it on another revision of this system.

## Current notes:
- `amdgpu` resets not yet observed, but not known if resolved.

### Shortcuts
- [Devices](#devices)
- [Gotchas](#gotchas)
- [Setting up the XR Stack](#setting-up-the-xr-stack)
- [Working games](#working)
- [Partially working games](#partially-working)
- [Not working games](#not-working)
- [Software](#software)

---

## Devices

---

### VR Hardware
- PICO 4 (256GB)
    - Typically used wireless.
    - PICO Motion Trackers work about as well as they are supposed to.
    - Left controller seems to be failing now.
      - Keeps dropping out on occasion, and the capacitive sensors keep getting stuck on or off.
      - It's always the left controllers lol. My left WMR controller way back when was so power-hungry compared to the right.
- Quest 3s (128GB)
    - Typically used wireless. I use this primarily for Beat Saber due to its higher refresh rate and more stable controller prediction.
      - The PICO 4's controller offsets are weird, man. They flip all over the place.
    - Can be used in the dark, so if I want the lights off, this headset's the way to go.
- Common notes
    - Hand Tracking works fine in titles that support it (that is, VRChat). Make sure it's enabled at the system level prior to launching WiVRn for the option to be available.
        - For PICO, this is under Settings > Lab > Hand Tracking.
    - Presence isn't passed through at this time, so VRChat doesn't trigger its AFK state, Vivecraft won't hotswitch automatically, etc.

### PC Hardware
- AMD Ryzen 5 5600G (iGPU disabled in BIOS)
- AMD Radeon RX 6600XT (8GB)
- 32GB RAM (2x16GB, 3600MHz, DDR4)
- OS is on a SATA SSD.
- Most games installed on a hard drive, some on an NVMe.

### PC Software
- Distro: Fedora 43 (upgraded from Fedora 41)
- Desktop: KDE Plasma, Wayland
- Steam: `dnf` package (i.e. not the flatpak)
    - Flatpak Steam *can* work, though I've had trouble with it myself. See: [LVRA Wiki > WiVRn > Steam Flatpak](https://lvra.gitlab.io/docs/fossvr/wivrn/#steam-flatpak).
- Epic Store, GOG, and non-Steam games: Heroic Games Launcher (AppImage version)
- Proton: [GE-Proton9-18](https://github.com/GloriousEggroll/proton-ge-custom/releases/tag/GE-Proton9-18) (Default for all games and launchers, unless otherwise specified)
    - To install a custom Proton version, I typically use [ProtonUp-Qt](https://github.com/DavidoTek/ProtonUp-Qt) (in Flatpaks, look for `pupgui2`).
    - For manual installation (such as for the [GE-RTSP variant](https://github.com/SpookySkeletons/proton-ge-rtsp)), place the tool's folder in `.steam/steam/compatibilitytools.d/`.
- XR Stack (manually built):
    - [WiVRn](https://github.com/WiVRn/WiVRn) - Monado-based OpenXR runtime and streamer for Standalone HMDs.
    - [xrizer](https://github.com/Supreeeme/xrizer) - OpenVR > OpenXR compatibility layer.
    - [WayVR](https://github.com/wlx-team/wayvr) - An overlay application that provides desktop views and playspace drag.
        - I have my Space Drag mapped to left/right stick click, with Space Reset mapped to double-clicking the left stick.
    - SteamVR is *not* installed, and in most cases shouldn't be as it can conflict with WiVRn.

---

## Gotchas
Some things to be careful of.

---

### Easy Effects
- This seems to cause WiVRn's audio to become crunchy/robotic. To work around, do one of the following:
    - Override `Pipewire > General > Use default output` with a specific, non-WiVRn device. Naturally, this is only viable if you only have one audio output you would ever need filtered at a time.
        - Yes, EasyEffects seems to process the outputs even when there are no effects selected.
    - In the Output tab, turn on the `Exclude` toggle for your active VR applications. (WayVR, Beat Saber, VRChat, etc)
    - Disable its effect on audio outputs as a whole.
    - Close down Easy Effects completely.
- I have heard people say my voice went "robotic" momentarily, and I presume this is also EasyEffects' fault. To be safe I've also overridden `Pipewire > General > Use default input` with my desktop mic.
    - Since the WiVRn client has a built-in noise reduction solution already, there's not much point allowing it to be filtered again. (unless I wanna pitch-change or something, but frankly, I'd rather learn to control my voice myself than have the computer do it)
    - I unplug my desktop mic when not in use, so it may "fall back" to the WiVRn mic. In my case, I have a little USB Capture card that it falls back to.

### PROTON_LOG
- I learnt this the hard way; if you have added `PROTON_LOG=1` to your launch arguments, try not to forget.
  - My VRChat was unplayably laggy for weeks and I had no idea why until I went to the launch options to remove `--enable-debug-gui` and noticed it there from when I was debugging something.

---

## Setting up the XR Stack
Surface-level summary of setting up the WiVRn Server (headless) with xrizer and WayVR.

---

**NOTE**: If you just want to *use* WiVRn, and don't want/need to build everything yourself, try the `wivrn-dashboard` package provided by your system (or the WiVRn Flatpak) with the WayVR package or AppImage.
- Once you have it installed, the system package should come with a systemd service. If you'd like to have WiVRn auto-start on login: `systemctl enable --user wivrn` and `systemctl start --user wivrn`. I am unsure if the Flatpak does the same.

[`wayvr`](https://github.com/wlx-team/wayvr/wiki/Building-from-Source):
- Clone + build, note where the executable is.
  - e.g. `~/devel/xr/target/release/wayvr`

[`wivrn-server`](https://github.com/WiVRn/WiVRn/blob/master/docs/building.md#server-pc):
- Clone + build, note where the executable is.
  - e.g. `~/devel/xr/WiVRn/build-server/server/wivrn-server`
- Run `wivrn-server`
  - Configure the headset, may need to run `wivrnctl pair` to pair with your HMD.
- `~/.config/wivrn/config.json` > set `"application"` to point to the `wayvr` executable.
- Create systemd service to run `wivrn-server` at login/desktop init.
    - Then, if you set Auto Connect on the headset, you can simply open WiVRn on the headset and you're in VR.

[`xrizer`](https://github.com/Supreeeme/xrizer?tab=readme-ov-file#building):
- Clone + build.
- `~/.config/openvr/openvrpaths.vrpath` > set `"runtime"` to point to xrizer build folder.
  - e.g. `~/devel/xr/xrizer/target/release/`
  - A sample `openvrpaths.json` is in this xrizer build dir; you should be able to just copy this file over instead.

I've made symlinks for each application, so I have a neat set of shortcuts all in one folder:
- `~/Programs/xr/` (added to `PATH`)
  - `xrizer/` -> `~/devel/xr/xrizer/target/release/`
  - `wayvr` -> `~/devel/xr/target/release/wayvr`
  - `wivrn-server` -> `~/devel/xr/WiVRn/build-server/server/wivrn-server`

As well, I have made some scripts that run `git pull` and then the build command for each application, as well as another that runs all of them.
If I really wanted to, I could simply make a cron job that runs this `build_all.sh` script, so my entire XR stack auto-updates itself! Though, this comes with some concerns:
- If there's been no commits, why bother re-building? It's a waste of energy and disk IO, so we should check the current and latest commits before updating.
- If I'm auto-updating to the latest commit, then if something happens to break upstream I'll have to work out how to get up and running again the next time I want to hop into VR, instead of when I'm *aware* that I might break it by choosing to run updates.

---

## Working
Things we can actually play! Yay! There may be small issues here and there but these are not typically game-breaking.

^ - Using a different Proton version. (notes will mention why)

---

### ^ VRChat
- Using GE-Proton10-20-rtsp19. (RTSP is the [recommended fork for VRChat](https://lvra.gitlab.io/docs/vrchat/#recommended-proton))
- Uses the following launch options, including [gamemoderun](https://github.com/FeralInteractive/gamemode):
    - `gamemoderun %command% --enable-avpro-in-proton --disable-amd-stutter-workaround --enable-hw-video-decoding`
    - Some of these launch options have been deprecated recently, I'll update this when I work out which ones.
- World "Connecting" screen thumbnails' colours are just a bit off. Gamma issue? Wrong colour space?
- Full-body tracking works just fine.

#### [ToN Save Manager](https://github.com/ChrisFeline/ToNSaveManager) for Terrors of Nowhere (VRChat)
- I run this via [Protontricks](https://github.com/Matoking/protontricks) inside the VRChat prefix (appid 438100).
    - i.e. `flatpak run --command=protontricks-launch com.github.Matoking.protontricks --appid 438100 ./ToNSaveManager.exe`
    - Also, see this [launch script](vrchat/launch-ton-save-manager.sh) I made that works around a crash on launch.
- Seems to work fine. Finds save files in the logs, saves copy when clicked, and even OSC works.
  - You can test OSC with [Rin the Witch](https://vrchat.com/home/avatar/avtr_0ae41d3f-ae4a-437d-b429-4b1dbb217d20) from Spookality 2024. The gold on her outfit should change colour to match the Terror's colour shown in the wrist UI. Make sure OSC colour is set to HSV.

### ^ Beat Saber (1.40.8 Modded)
- Using Proton Experimental, due to mod-loading issues with Proton-GE way back when I used Flatpak WiVRn.
- I currently use [BSManager](https://github.com/Zagrios/bs-manager) for modding and launching Beat Saber 1.40.8.
    - If you want to use [Beat Saber Mod Manager](https://github.com/affederaffe/BeatSaberModManager) (which I still use for OneClick installation), settings and selected mods do not save on v0.0.6, so use v0.0.5 instead.
- Full-body tracking doesn't seem to work; OpenXR Tracker Profiles either doesn't load or can't detect the trackers.

### ^ Resonite
- Using GE-Proton10-15-rtsp18.
- I have my mods disabled since the .NET 10 update broke them. Might get them back later if I can be bothered.
- Full-body tracking works just fine.

### ^ Until You Fall
- Using GE-Proton7-55, unsure if other versions work.
- With XRizer, this gets past the black screen and is somehow playable. Occasional crash on launch that should be fixed on the latest commits of XRizer.
- Performance is sub-par, I lowered my resolution significantly (`OXR_VIEWPORT_SCALE_PERCENTAGE=50`) and it's still not perfect.

### ChilloutVR
- Full-body tracking Works mostly fine:
  - Some quirks with the body being pulled along with the legs sometimes, probably due to the platform's IK setup or my settings.
  - (todo: re-test) Touching the ground with most avatars puts them in a "crouch" pose or flickers rapidly between standing and "crouching".
      - Avatars that are playspaced above the ground or have Locomotion disabled seem to behave as expected.

### Vertigo: Remastered
- Nothing much to note. From a brief test, the menu controls work and you can try to stop the first boss-thing from slapping you. I'm not very good at it.

### [Whimsy](https://peopleofwhimsy.itch.io/whimsy) (yoo i worked on this one)
- Requires the environment variable `PROTON_USE_WINED3D=1` ([thanks](https://bbs.archlinux.org/viewtopic.php?id=306674)), otherwise the Unity Player will fail to create a D3D11 device and crash immediately on launch.
    - i.e. set your launch options to `PROTON_USE_WINED3D=1 %command%`
    - Unity 6 seems to have issues on Linux in general; see versions of Beat Saber after 1.40.8. Whimsy was originally built on Unity 2022, and *did* run perfectly under Proton back then without this workaround. Currently, it's built on Unity 6.2.

---

## Partially working
These launch, but have issues functioning normally and may have completely broken parts.

---

### Superhot VR
- Grabbing is mapped to Trigger, and seems unable to drop items.
    - Throwing things and thus progressing through certain areas therefore seems impossible.

---

## Not working
The following crash on launch or have other major issues that prevent them from working at all.

---

### ^ Half-Life: Alyx (Proton)
- Using Proton Experimental.
- Launch Options: `OXR_VIEWPORT_SCALE_PERCENTAGE=50 %command% -novid -console -vconsole +vr_fidelity_level_auto 0 +vr_fidelity_level 3`
  - 50% resolution scale, skip intro video, and disable dynamic resolution, the last of which can cause white bars on the sides of vision.
- Crash on launch. Need further investigation; Alyx's ability to avoid crashes has never been consistent on my system.

### ^ Catlateral Damage VR (Proton)
- Using GE-Proton7-55. VR Mode is only available when using the Windows build via Proton.
- Crash on launch.

---

## Software
Troubleshooting setup of other, non-game software.

---

### Steam (native) - if you hate editing Launch Options for every game (+ auto OBS Game Capture):
- Close Steam
- Edit your Steam shortcut to add the Environment Variables set by WiVRn.
  - On KDE, you can right-click the Application Launcher > Edit Applications > Steam and add them in the box.
  - This should add the WiVRn Env Vars to every Steam game so you don't have to manually edit the launch options every time you install a new game.
  - If you're using OBS's OBS_VKCapture plugin, you may also add `OBS_VKCAPTURE=1` here.
    - Note that you will still need to add the `obs-gamecapture %command%` Launch Option for games that do not use Vulkan.
- Re-open Steam

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
    - Instead, using the Unity Hub binary from the yum repo provided by Unity seems to resolve this issue.

### Blender (VR Scene Inspection Addon)
- On Wayland, starting the OpenXR Session may result in an error `XR_ERROR_GRAPHICS_DEVICE_INVALID`.
    - Changing the graphics backend to `Vulkan` under `Edit > Preferences > System > Display Graphics` should fix this.

---
