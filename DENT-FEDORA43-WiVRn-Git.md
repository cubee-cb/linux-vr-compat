Testing VR games with WiVRn and WayVR on Fedora, using XRizer for SteamVR/OpenVR compatibility.

Since WiVRn is being removed from Envision, I finally have an excuse to move away from it and make my XR stack more automated myself.

If a game isn't listed here, check out the other files to see if I've tried it on another revision of this system.

## Current notes:
- `amdgpu` resets not yet observed, but not known if resolved.

### Shortcuts
- [Devices](#devices)
- [Gotchas](#gotchas)
- [Setting up the XR Stack](#setting-up-the-xr-stack)
- [Useful ENV Vars](#useful-env-vars)
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
    - Can be used in the dark, so if I wanted the lights off for whatever reason, this headset's the way to go.
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
    - All Launch Options should be combined with the ones specified by WiVRn.
- Epic Store, GOG, and non-Steam games: Heroic Games Launcher (AppImage version)
- Proton: [GE-Proton10-32](https://github.com/GloriousEggroll/proton-ge-custom/releases/tag/GE-Proton10-32) (Default for all games and launchers, unless otherwise specified)
    - To install a custom Proton version, I typically use [ProtonUp-Qt](https://github.com/DavidoTek/ProtonUp-Qt) (in Flatpaks, look for `pupgui2`), though Heroic works too if you turn on "Download GE-Proton to Steam directory", then they can share installs.
    - For manual installation (such as for the [GE-RTSP variant](https://github.com/SpookySkeletons/proton-ge-rtsp)), place the tool's folder in `.steam/steam/compatibilitytools.d/`.
- XR Stack (manually built; the release builds may lack some features I talk about here):
    - [WiVRn](https://github.com/WiVRn/WiVRn) - Monado-based OpenXR runtime and streamer for Standalone HMDs.
    - [xrizer](https://github.com/Supreeeme/xrizer) - OpenVR > OpenXR compatibility layer.
    - [WayVR](https://github.com/wlx-team/wayvr) - An overlay application that provides desktop views and playspace drag.
        - I have my Space Drag mapped to left/right stick click, with Space Reset mapped to double-clicking the left stick. This does conflict with some games; in this case you can set Playspace Multiplier to 0 in WayVR's settings.
    - SteamVR is *not* installed, and in most cases shouldn't be as it can conflict with WiVRn.

---

## Gotchas
Some things to be careful of.

---

### Easy Effects
- If your audio sounds crunchy or robotic:
    - Update WiVRn to 26.2 or newer. System Packages may lag behind, but Flatpak is updated already.
    - Override `Pipewire > General > Use default output` and/or `Pipewire > General > Use default input` with a specific, non-WiVRn device. Naturally, this is only viable if you only have one audio output you would ever need filtered at a time.
        - Yes, EasyEffects seems to process the outputs even when there are no effects selected.
    - In the Output tab, turn on the `Exclude` toggle for your active VR applications. (WayVR, Beat Saber, VRChat, etc)
    - Disable its effect on audio outputs as a whole.
    - Close down Easy Effects completely.

### PROTON_LOG
- I learnt this the hard way; if you have added `PROTON_LOG=1` to your launch arguments, try not to forget.
  - My VRChat was unplayably laggy for weeks and I had no idea why until I went to the launch options to remove `--enable-debug-gui` and noticed it there from when I was debugging something.

### Anti-Aliasing Performance
- From what I hear, anti-aliasing is a big no-no for Linux VR. The performance cost far outweighs the slight benefit in visual smoothness, so usually you are better off disabling anti-aliasing all together.

---

## Setting up the XR Stack
Surface-level summary of setting up the WiVRn Server with xrizer and WayVR.

---

**NOTE**: If you just want to *use* WiVRn, and don't want/need to build everything yourself, try the [`wivrn-dashboard` system package](https://github.com/WiVRn/WiVRn?tab=readme-ov-file#pc-serverdashboard) (needs OpenVR > OpenXR translation layer installed separately) or the [WiVRn Flatpak](https://flathub.org/en/apps/io.github.wivrn.wivrn) (OpenVR compatibility built-in) with the [WayVR AppImage](https://github.com/wlx-team/wayvr?tab=readme-ov-file#installation).
- Once you have it installed, the system package should come with a systemd service. If you'd like to have WiVRn auto-start on login: `systemctl enable --user wivrn` and `systemctl start --user wivrn`. I am unsure if the Flatpak does the same.

### [`wayvr`](https://github.com/wlx-team/wayvr/wiki/Building-from-Source):
- Clone + build, note where the executable is.
  - e.g. `~/devel/xr/wayvr/target/release/wayvr`

### [`wivrn-dashboard`](https://github.com/WiVRn/WiVRn/blob/master/docs/building.md#dashboard) for GUI, or [`wivrn-server`](https://github.com/WiVRn/WiVRn/blob/master/docs/building.md#server-pc) for headless:
- Clone + build, note where the executable is.
  - e.g. `~/devel/xr/WiVRn/build-dashboard/server/wivrn-dashboard` or `~/devel/xr/WiVRn/build-server/server/wivrn-server`
- Run `wivrn-dashboard` for initial setup and pairing your headset.
    - Remember to set the Autostart Application to the `wayvr` executable, if you want to use that.
    - For `wivrn-server` (headless): Run `wivrnctl pair` to pair with your HMD. Config is under `~/.config/wivrn/config.json`: add the path of the `wayvr` executable to `"application"`.
- Create a nice shortcut to launch WiVRn:
    - For GUI, in your desktop environment you can usually create a Launcher on the desktop or an entry in the applications menu, though this will vary from environment to environment.
        - Set this to point at the `wivrn-dashboard` executable.
        - You can find the WiVRn icons under `WiVRn/images/`.
    - For headless, you could create systemd service to run `wivrn-server` at login/desktop init, then, if you set Auto Connect on the headset, you can simply open WiVRn on the headset and you're in VR. Comes with caveats:
        - If using WayVR, you have to manually close WayVR before the XR session will shutdown. IIRC you may be able to do this under Settings > Troubleshooting? Otherwise, there's always `kill`.
        - If you need to restart the server, `systemctl restart` the service.

### [`xrizer`](https://github.com/Supreeeme/xrizer?tab=readme-ov-file#building):
- Clone + build, note where the `xrizer/target/release/` or `xrizer/target/debug/` folder is.
- `~/.config/openvr/openvrpaths.vrpath` > set `"runtime"` to point to this folder.
  - e.g. `~/devel/xr/xrizer/target/release/`
  - A sample `openvrpaths.json` is in this xrizer build dir; you should be able to just copy this file over instead.

### Next
I've made symlinks for each application, so I have a neat set of shortcuts all in one folder:
- `~/Programs/xr/` (added to `PATH`)
  - `xrizer/` -> `~/devel/xr/xrizer/target/release/`
  - `wayvr` -> `~/devel/xr/target/release/wayvr`
  - `wivrn-dashboard` -> `~/devel/xr/WiVRn/build-dashboard/server/wivrn-dashboard`
  - `wivrn-server` -> `~/devel/xr/WiVRn/build-dashboard/server/wivrn-server`
  - `wivrnctl` -> `~/devel/xr/WiVRn/build-dashboard/server/wivrnctl`

As well, I have made some scripts that run `git pull` and then the build command for each application, as well as another that runs all of them.
If I really wanted to, I could simply make a cron job that runs this `build_all.sh` script, so my entire XR stack auto-updates itself! Though, this comes with some concerns:
- If there's been no commits, why bother re-building? It's a waste of energy and disk IO, so we should check the current and latest commits before updating.
- If I'm auto-updating to the latest commit, then if something happens to break upstream I'll have to work out how to get up and running again the next time I want to hop into VR, instead of when I'm *aware* that I might break it by *choosing* to run updates.

---

## Useful ENV vars
Environment variables that are useful. Usually, these are put into Steam Launch Options per-game (or your launcher / shortcut's equivalent) before the program/command itself, and are space-separated. (i.e. `ENV_VAR=1 xrgears` or `ENV_VAR=1 ANOTHER_ENV_VAR=500 %command%`)

---

### OXR_VIEWPORT_SCALE_PERCENTAGE
- Add `OXR_VIEWPORT_SCALE_PERCENTAGE=50` (where `50` is your desired percentage) to alter the resolution this application renders at. This allows you to make more intensive games run better at the cost of clarity, similar to SteamVR's Per-Application Video Settings. This can also be set above `100` to supersample the application.
- It may be useful for WayVR, or other text-heavy programs, but for this purpose it may be better to increase the Stream Resolution and lower the games' viewport scales instead.

### OXR_RECENTER_STAGE
- Add `OXR_RECENTER_STAGE=1` to allow recentering Stage Space with the headset's Recenter action. This should resolve e.g. Beat Saber's recentering.
- As far as I'm aware, this is because most games recenter Stage rather than Local. As Stage is not supposed to recenter (that is the purpose of Local, as the player's Origin), this environment variable allows you to "break" the spec and restore recentering functionality.

---

## Working
Things we can actually play! Yay! There may be small issues here and there but these are not typically game-breaking.

^ - A different Proton version is Required or Works Better. (notes will mention why)

---

### ^ VRChat
- Using GE-Proton10-26-rtsp20. (RTSP is the [recommended fork for VRChat](https://lvra.gitlab.io/docs/vrchat/#recommended-proton))
- Uses the following launch options, including [gamemoderun](https://github.com/FeralInteractive/gamemode):
    - `gamemoderun %command% --enable-avpro-in-proton`
- World "Connecting" screen thumbnails' colours are just a bit off. Gamma issue? Wrong colour space?
- Full-body tracking works just fine.
- Gotchas:
    - VRChat seems not to launch after EAC if `OBS_VKCAPTURE` is set. Perhaps it doesn't like the Vulkan layer?

#### [ToN Save Manager](https://github.com/ChrisFeline/ToNSaveManager) for Terrors of Nowhere (VRChat)
- I run this via [Protontricks](https://github.com/Matoking/protontricks) inside the VRChat prefix (appid 438100).
    - i.e. `flatpak run --command=protontricks-launch com.github.Matoking.protontricks --appid 438100 ./ToNSaveManager.exe`
    - Also, see this [launch script](vrchat/launch-ton-save-manager.sh) I made that works around a crash on launch.
- Seems to work fine. Finds save files in the logs, saves copy when clicked, and even OSC works.
  - You can test OSC with [Rin the Witch](https://vrchat.com/home/avatar/avtr_0ae41d3f-ae4a-437d-b429-4b1dbb217d20) from Spookality 2024. The gold on her outfit should change colour to match the Terror's colour shown in the wrist UI. Make sure OSC colour is set to HSV.

### ^ Beat Saber (1.40.8 Modded)
- Using Proton Experimental, due to issues getting mods to load with Proton-GE way back when I used Flatpak WiVRn.
- I currently use [BSManager](https://github.com/Zagrios/bs-manager) for modding and launching Beat Saber 1.40.8.
    - If you want to use [Beat Saber Mod Manager](https://github.com/affederaffe/BeatSaberModManager) (which I still use for OneClick installation), settings and selected mods do not save on v0.0.6, so use v0.0.5 instead.
- Full-body tracking doesn't seem to work; OpenXR Tracker Profiles either doesn't load or can't detect the trackers.

### ^ Resonite
- Using GE-Proton10-15-rtsp18 for better video stream support.
- I have my mods disabled since the .NET 10 update broke them. Might get them back later if I can be bothered.
- Full-body tracking works just fine.
- Gotchas:
    - May not launch if `OBS_VKCAPTURE` is set. Perhaps it doesn't like the Vulkan layer?

### Half-Life: Alyx (Native)
- Seems to flip-flop between whether the Native or Proton version wants to work at any given time. We'll see how long this lasts.
- Launch Options: `OXR_VIEWPORT_SCALE_PERCENTAGE=70 %command% -novid -nowindow -console -vconsole +vr_msaa 0`
  - 70% resolution scale, skip Valve Guy intro, disable spectator/desktop window, disable anti-aliasing.
  - If there are white bars on the edges of your vision, try adding `+vr_fidelity_level_auto 0 +vr_fidelity_level 3` to disable Dynamic Resolution. (this was an issue in OpenComposite; it may not be necessary at all for xrizer)
  - To make movement faster, add `+hlvr_continuous_normal_speed 150 +hlvr_continuous_combat_speed 150` (to personal taste).
- !! Loading screens are invisible. Just wait for the sound ping then press a trigger and it should continue. Subtitles are also missing, but from what I hear this can be fixed with a symlink. (I don't care to fix those myself, though)
    - I *thought* loading times were abysmal, but I had forgotten they need input to proceed. They're actually quite short on an NVMe!
- As for performance, this hits my system hard.
    - Performance is not smooth at all, even on Low Fidelity with these Launch Options disabling things. It feels like VRChat. (that is in no way a compliment)
    - This as abysmal compared to how well it ran on my old WMR headset on Windows with High/Ultra Fidelity, mostly only bogging down towards the ending chapters. Very playable despite WMR being WMR.
    - Maybe the extra overhead of ~2x the pixel count + stream encoding pushes it over the edge? `htop` and `nvtop` stats don't seem to reveal a bottleneck.
    - One time I restarted the game and it ran like utter rubbish. Subsequent runs were the same. Later during the zombie-trains room it became unplayably stuttery. Recording from the HMD revealed the view flickering around constantly.
- Other notes:
    - To share saves between the Windows and Native builds, go to `steamapps/common/Half-Life Alyx/game/hlvr/` and replace `SAVE` with a symlink to `save` (or the other way if `SAVE` contains your save files).
    - If you try using hand tracking, the fingers will move as if using Knuckles controllers, but the hands remain at the controllers' positions.

### ^ Until You Fall
- Using GE-Proton7-55, unsure if other versions work.
- With XRizer, this gets past the black screen and is somehow playable. Occasional crash on launch that should be fixed on the latest commits of XRizer.
- Performance is sub-par, I lowered my resolution significantly (`OXR_VIEWPORT_SCALE_PERCENTAGE=50`) and it's still not particularly smooth.

### ChilloutVR
- Tested: GE-Proton9-18
- Full-body tracking Works mostly fine:
  - Some quirks with the body being pulled along with the legs sometimes, probably due to the platform's IK setup or my settings.
  - (todo: re-test) Touching the ground with most avatars puts them in a "crouch" pose or flickers rapidly between standing and "crouching".
      - Avatars that are playspaced above the ground or have Locomotion disabled seem to behave as expected.

### Vertigo: Remastered
- Tested: GE-Proton9-18
- Nothing much to note. From a brief test, the menu controls work and you can try to stop the first boss-thing from slapping you. I'm not very good at it.

### [Whimsy](https://peopleofwhimsy.itch.io/whimsy) (yoo i worked on this one)
- Requires the environment variable `PROTON_USE_WINED3D=1` ([thanks](https://bbs.archlinux.org/viewtopic.php?id=306674)), otherwise the Unity Player will fail to create a D3D11 device and crash immediately on launch.
    - i.e. set your launch options to `PROTON_USE_WINED3D=1 %command%`
    - Unity 6 seems to have issues on Linux in general; Whimsy was originally built on Unity 2022, and *did* run perfectly under Proton back then without this workaround. Currently, it's built on Unity 6.2.

---

## Partially working
These launch, but have issues functioning normally and may have completely broken parts.

---

### Superhot VR
- Tested: GE-Proton9-18
- Grabbing is mapped to Trigger, and seems unable to drop items.
    - Throwing things and thus progressing through certain areas therefore seems impossible.

---

## Not working
The following crash on launch or have other major issues that prevent them from working at all.

---

### ^ Half-Life: Alyx (Proton)
- Using Proton Experimental. GE-Proton also fails.
- Launch Options: `OXR_VIEWPORT_SCALE_PERCENTAGE=70 %command% -novid -nowindow -console -vconsole +vr_msaa 0`
  - 70% resolution scale, skip Valve Guy intro, disable spectator/desktop window, disable anti-aliasing.
- Crash on launch. Needs further investigation; Alyx isn't supposed to be in a crash this early. `PROTON_LOG` returns some of these:
    - `err:msvcrt:_wassert (L"!status",L"../src-vrclient/winIVRMailbox.c",51)`
    - `err:service:device_notify_proc failed to get event, error 1726`

### ^ Catlateral Damage VR (Proton)
- Using GE-Proton7-55. VR Mode is only available when using the Windows build via Proton. Unsure if newer versions work.
- Crash on launch.

---

## Software
Setup and troubleshooting of other, non-game software.

---

### Steam (native) - if you hate editing Launch Options for every game (+ auto OBS Game Capture):
- Close Steam.
- Edit your Steam shortcut to add the Environment Variables set by WiVRn.
  - On KDE, you can right-click the Application Launcher > Edit Applications > Steam and add them to the appropriate box.
  - This should add the WiVRn Env Vars to every Steam game so you don't have to manually edit the launch options every time you install a new game.
  - Doing this next bit seems to break VRChat and Resonite, but if you're using OBS's OBS_VKCapture plugin, you may also add `OBS_VKCAPTURE=1` here.
    - Note that you will still need to add the `obs-gamecapture %command%` Launch Option for games that do not use Vulkan, so it may be worth just adding the launch option to everything manually.
- Re-open Steam.

### ALCOM ([vrc-get-gui](https://github.com/vrc-get/vrc-get/blob/master/vrc-get-gui/README.md))
- Alternative Creator Companion for VRChat.
- The AppImages display a white screen on launch, so building ALCOM manually is pretty much required on this system.
    - EGL Display error. Basically identical to [this comment](https://github.com/vrc-get/vrc-get/issues/1694#issuecomment-2480857765) on the white screen issue thread.
- Needed to install DNF packages `nodejs-npm gtk3-devel libsoup3-devel javascriptcoregtk4.1-devel webkit2gtk4.1-devel dotnet-sdk-8.0` and cargo crate `cargo-about`.
- Final step of build fails to bundle the AppImage. By this point, the raw executable has been built in `vrc-get/target/release/` anyway.
    - As long as it says `Built application at: /home/user/.../vrc-get/target/release/ALCOM` you should be all good.
    - Might break some things if it expects to be running as an AppImage, for example the setting `Use ALCOM for vcc: URL Scheme` shows a "failed to get appimage path" error, more remains to be seen.
- As for Unity Hub itself:
    - Launching the Flatpak version of Unity Hub though ALCOM fails with a "No valid license found" error, no matter which variant of ALCOM I use. Instead, using the Unity Hub binary from the yum repo provided by Unity seems to work around this issue.

### Blender (VR Scene Inspection Addon)
- On Wayland, starting the OpenXR Session may result in an error `XR_ERROR_GRAPHICS_DEVICE_INVALID`.
    - Changing the graphics backend to `Vulkan` under `Edit > Preferences > System > Display Graphics` should work around this.

---
