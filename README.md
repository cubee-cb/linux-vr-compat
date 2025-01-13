# linux-vr-compat
Testing VR games on my Linux setup with WiVRn and WlxOverlay-S.
Other files include scripts or configs that I use.

**Note**: Lately `amdgpu` has been encountering page faults and subsequent GPU resets for some systems, including mine.
It looks to be related to `linux-firmware` and video encoding/decoding on AMD GPUs, and in my experience typically occurs when using WiVRn, though it does happen outside of VR on occasion.
Seems to be tracked here:
- [Full OS crash when using media source](https://gitlab.freedesktop.org/drm/amd/-/issues/3855)

### Shortcuts
- [Setup](#setup)
- [Working games](#working)
- [Partially working games](#partially-working)
- [Not working games](#not-working)
- [Development/hardware](#developmenthardware)
- [Curiosities](#curiosities)
- [Untested](#untested)

## Setup

### Hardware
- AMD Ryzen 5 5600G
- AMD RX 6600XT 8GB
- 16GB RAM (2x8GB, 3200Mhz, DDR4)
- Everything installed on a hard drive. (including OS)
    - Plan to move OS to an SSD at some point, HDD speeds are starting to bottleneck as I do more things on this system.
- PICO 4 headset, with USB 3.0 cable.
    - Currently, I still have incorrect controller offsets for PICO 4 controllers. Supposedly it was fixed in v0.22, and indeed they look correct in the WiVRn client menu and maybe Wlx-Overlay-S, but they still have the wrong offset in OpenComposite applications.
    - Hand tracking works fine in titles that support it. Make sure it's enabled at the system level to turn it on in WiVRn. (Settings > Lab > Hand Tracking)
- Windows Mixed Reality HP VR1000-122a.
    - Just keeping it going for 5 more minutes. No controller tracking.

### Software
- Fedora 41 (KDE Plasma, Wayland)
- WiVRn (Flatpak) to connect to the PICO 4 and emulate SteamVR via OpenComposite.
- Envision with WMR profile.
    - Mostly functional. Reprojection is laggy. [Has other issues](#developmenthardware).
- WlxOverlay-S for desktop views and playspace drag.
    - Space Drag is either left/right stick click, Space Reset is double-click left stick.
    - Custom build with battery OSC parameters, this has been [merged with main](https://github.com/galister/wlx-overlay-s/pull/108) as of now but has yet to be included in a release.
- Most games run through Steam (Runtime), SteamVR is not installed. Using launch arguments provided by WiVRn to make games use it as the VR runtime. Manually. For each game individually. (there's probably a more efficient way to do it other than switching to Envision for both headsets)
- Proton: GE-Proton9-18 (unless otherwise specified)


## Working
Things we can actually play! Yay!

^ - Requires a different Proton version.

### VRChat
- Updated to GE-Proton9-20-rtsp16 to hopefully fix video players being weird again, and since RTSP is the [recommended fork for VRChat](https://lvra.gitlab.io/docs/vrchat/#recommended-proton). GE-Proton9-18 works fine otherwise.
- World "Connecting" screens are broken, known OpenComposite quirk.
- Uses [gamemoderun](https://github.com/FeralInteractive/gamemode) and custom start script from [Linux VR Adventures Wiki](https://lvra.gitlab.io/docs/vrchat/eac/).
    - idk if the start script helps much though.
- Terrors of Nowhere
    - [ToN Save Manager](https://github.com/ChrisFeline/ToNSaveManager) runs via [Protontricks](https://github.com/Matoking/protontricks) inside the VRChat prefix (appid 438100).
        - See the VRChat folder for a launch script using flatpak Protontricks.
        - Seems to work fine. Finds save files in the logs, saves copy when clicked, and even OSC works.
            - You can test OSC with [Rin the Witch](https://vrchat.com/home/avatar/avtr_0ae41d3f-ae4a-437d-b429-4b1dbb217d20) from Spookality 2024. The gold on her outfit should change colour to match the Terror's colour shown in the UI. Use the HSV colours setting.
- Sometimes launching in VR bombards me with Anti-Cheat errors, despite using the start script. These errors actually have text though, saying the files failed to verify, and may also be related to the system being overloaded while starting. Perhaps this is related to my HDD speed issue.
- Non-16:9 videos on video players get stretched, which doesn't occur on PICO Standalone and Windows.
    - Exhibited on ProTV 3 in [my home world](https://vrchat.com/home/launch?worldId=wrld_f79b0387-d681-409a-bbe8-4a40cc8528ce).

### ^ Beat Saber
- Modding with [Beat Saber Mod Manager](https://github.com/affederaffe/BeatSaberModManager).
    - Settings and selected mods do not save on v0.0.6, use v0.0.5 instead.
- Mods do not load with GE-Proton9-18, but do with Proton Experimental.

### Pistol Whip
- First launch takes ages, possibly in part due to being on a hard drive, but otherwise works perfectly.

### The Lab
- Loading screens are broken.

### Sushi Ben Demo

### ^ Ragnarock
- Successfully launches with GE-Proton7-55. Fails to launch with D3D11 error on latest.
- Hammer/drum offsets seem to get stuck changing when adjustments are made, even when the joystick is released.

### ^ Into the Radius
- Successfully launches with GE-Proton7-55. Fails to launch with D3D11 error on latest.
- Extremely blurry by default, had to increase in-game resolution scale and turn off TAA.

### Vacation Simulator

### Rumble
- Desktop window complains that the wrong OpenXR runtime is being used, but ignore that and it seems to work fine.

### VAIL
- Works despite the recent addition of Denuvo anti-cheat in patch 1.2.4 on 3 October 2024.
- Default bindings have fire on trigger touch rather than pull.
    - I've managed to obtain a bindings file from the `steamapps/workshop/` folder for SteamVR on another device, but I can't seem to get OpenComposite to pick it up. ([LVRA Wiki](https://lvra.gitlab.io/docs/fossvr/opencomposite/))
    - I have tried [XRBinder](https://lvra.gitlab.io/docs/fossvr/xrbinder/), but can't get it to detect OpenComposite, or anything other than WlxOverlay.
- Menus are very flickery.
- Large stutters while loading maps, likely due to running on a hard drive.

### ChilloutVR

### Down the Rabbit Hole

### Propagation VR

### Rec Room
- Alpha on the EAC window is broken, causing black squares.
- The game will fail to login with error code "wrapper" unless you install "Proton Easy Anti Cheat Runtime" through Steam.
    - This may affect VRChat, however. See VRChat's section above.
- After logging in the first time, an OpenComposite window appeared simply saying "An error has occured". Subsequent launches seem to go smoothly.
- Loading screens are broken a la VRChat, but the game itself looks fine as opposed to what some people have been saying for Rec Room on OpenComposite.
- Rec Room, hire me so I can fix all the broken weights in your outfits, the Aviator Gloves have like 3 verts weighted wrong each.

### SUPERHOT VR (Pre-removed scenes version via depot download)

### Hellblade: Senua's Sacrifice VR Edition
- First launch crashed on starting a new game. Subsequent launch was fine, however.
- A certain cutscene near the start of the game has Senua's head clip through the cutscene border and into the camera, which was fairly weird to experience.

### Half Life: Alyx (Proton)
- Launches, menu interaction works, can load into a save file.
- Controller bindings are somewhat broken:
    - A and X are snap turn right/left respectively. A is also the reload action.
    - Left joystick seems to do nothing, but right stick turns and does teleport/jump as normal.
    - Weapon selection on joystick click conflicts with my space drag binding.
    - I've only played this on WMR so to be fair I have no idea what the controls are supposed to be like.
- On second launch I found that after loading into my save there was a white bar across the bottom and right sides of the rendered display, only visible due to reprojection.
    - Perhaps the dynamic resolution is broken? [This seems to help](https://www.pcgamingwiki.com/wiki/Half-Life:_Alyx#Disable_dynamic_resolution_scaling).

### [Beat Saber Origins](https://hyperbolicmagnetism.itch.io/beat-saber-origins) (via [Heroic Games Launcher](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher))
- Works perfectly. I just used Heroic because I had it installed for my Epic and GOG games.
- Setup:
    - Add the executable to Heroic through the Add Game button. Use Proton-GE-9-18, as Wine-GE-Proton doesn't support VR.
    - Add WiVRn's `PRESSURE_VESSEL` environment variable to Heroic's game settings (Advanced tab)

### ^ Kart Racing Pro rel11b (non-Steam version) (via Steam or [Heroic Games Launcher](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher))
- Playable, flickery shadows. Black screen in VR until actually in-game.
- Setup:
    - Add the executable to Steam or Heroic through the Add Game button. Use Proton-GE-7-55, as the game fails to launch with Proton-GE-9-18 and Wine-GE-Proton doesn't support VR.
    - Add the `-vr` launch option and WiVRn's `PRESSURE_VESSEL` environment variable to Steam's Launch Options or Heroic's Advanced tab.

### Vertigo: Remastered

### Keep Talking and Nobody Explodes
- Linux native doesn't support VR, use Proton instead.

## Partially working
These launch, but are unplayable or have serious issues functioning.

### Tea For God
- Hands don't appear, so cannot interact with anything.
- This setup doesn't provide a playspace at all, so only joystick locomotion is available.
    - Maybe [LOVR Playspace](https://lvra.gitlab.io/docs/fossvr/lovr/lovr-playspace/) could help with this, if it actually creates a playspace and isn't just visual.

### Slinger VR
- Controllers are stuck at the playspace origin and don't respond to input.

### Aperture Hand Lab
- Teleport binding is awkwardly mapped to stick click, and doesn't seem to confirm teleport on release.
- Playable with controllers up until the handshake bot due to lacking a grip pressure sensor. Hand tracking has no buttons and so it's unusable here.
    - This could be simulated using the grip analogue (say, the last 5-10%), but it will never be true pressure on current non-Knuckles controllers.

### Resonite (Proton, [see here](https://lvra.gitlab.io/docs/resonite/))
- Logged in, froze when loading my cloud home while in the tutorial, so it may not like changing worlds.
    - My cloud home is the default cloud home transferred from Neos, so world complexity/heaviness may not be the issue.
- Default stick-click to jump binding conflicts with my space-drag/reset bindings.
- My performance is abysmal and I often freeze when connecting to sessions, so for now I've demoted its status.
    - This may be due to running off a hard drive, I'll revisit this and add a note if running off an SSD fixes it.

### GRIP
- Plays perfectly with a traditional controller... until it crashes mid-race.
    - `Assertion failed: Wine C++ Runtime Library > /src-vrclient/winIVRSystem.c Line 8701 expression "!status"`, then `Fatal Error`.
    - Seems like it's a VR-specific error for running under Wine/Proton. That's a shame.
- Splash screens are displayed on the desktop, but once in the game menus it switches to VR.
- Desktop mode seems to work.
- Using GE-Proton7-55 seems to prevent the Wine error window from appearing, however it does not stop the crashing nor the `Fatal Error` window.

### Metal: Hellsinger VR Demo
- Starts and stays on a black screen. May need longer for initial load like Pistol Whip, hence being placed here instead of Not working.
- The game's custom cursor appears on the desktop window and can be moved around.

### Kingspray Graffiti
- Might work, but takes ages to load into a map. I gave up waiting.
- Again, might be related to HDD speed.

## Not working
The following crash on launch or have other major issues.

### Zenith VR
- Loading screens are broken.
- Crashes immediately after rendering the first loading screen with a texture error.
- Using GE-Proton7-55 doesn't help.

### Until You Fall
- Black screen after logo, black-screen-fix beta no longer exists?
- Using GE-Proton7-55 changes nothing.

### Half-Life 2 VR
- Launches, but fails to find the VR session.
- People in the LVRA Discord mentioned using a 32-bit build of WiVRn and OpenComposite. I'll keep an eye on that.

### Hyper Dash
- Fails to launch with an OpenComposite error for a stubbed file related to the chaperone.
- This also has a free standalone version on both PICO and Quest, so not too big a deal in this scenario.

### Vivecraft
- Running through Modrinth Launcher (FlatPak)
- Version: 1.20.1-1.1.14-fabric on Quilt Loader
- When entering VR mode it fails to locate installation path, presumably for SteamVR.
    - According to [the FAQ](https://www.vivecraft.org/faq/#opencomposite), Vivecraft supports OpenComposite, but I'm not sure how to get it to find it or if recent updates (such as moving to Fabric) broke things.
    - Providing environment variables according to [this video from Issac Dowling](https://www.youtube.com/watch?v=o8ho7VG13Ck&t=530s) to allow Modrinth Launcher to talk to WiVRn doesn't seem to change anything, though I may have made a mistake somewhere. Maybe I put them in the wrong spot.

### Project Cars
- Doesn't create a window, crashes shortly after Steam stops saying loading.

### Museum of Other Realities
- Crashes with a texture error after rendering the first logo, like Zenith.
- Using GE-Proton7-55 doesn't help.

### Half Life: Alyx (Native)
- Crashes on launch with no error window.

### COMPOUND
- OpenComposite error due to generated Microsoft Holographic (WMR) bindings missing the "none" action. Probably solvable.
- Supposedly works through [XRizer](https://github.com/Supreeeme/xrizer/), albeit with bad controller offsets, so I may try that in the future.

### Legend of Dungeon
- Linux native lacks the VR mode launch option on both live and beta.
- Proton+live has an old VR option that supposedly doesn't work, didn't bother testing.
- Proton+beta has SteamVR option, but it launches in desktop mode.

### Desert Bus VR
- Launches in desktop mode even when choosing the SteamVR launch option.

## Development/hardware
Troubleshooting setup of hardware or build issues.

### WlxOverlay-S
- Once all the dependencies were installed, no issues.

### Envision WMR Setup with the HP VR1000 HMD
- Using Envision DNF Package. (formerly AppImage)
- Building the WMR profile asks to install `boost boost boost boost boost` (yes, five times in a row), but what it actually needs is `boost-devel`.
- The HMD devices' udev rules must be installed. These are easily found in `xr-hardware`, which can be built from [xr-hardware](https://salsa.debian.org/rpavlik/xr-hardware) or found through `dnf`. Check `/etc/udev/rules.d`, the Fedora `dnf` package did not install the rules for me.
    - You could probably just put the `70-xrhardware.rules` file from that repo in `rules.d` manually.
- Controllers supposedly failed to pair via bluetooth menu and turned their lights off, but were still 'on'. Turning them off and on again allows them to connect although the bluetooth menu says they are not paired.
    - idk how to enable the controller tracking branch though, so we only have hand tracking at the moment.
    - Connecting them a few days later, they just blink and vibrate rapidly as if repeatedly connecting and disconnecting.
- (AppImage) Envision will fail to start Monado if either the `/run/user/1000/monado_ipc_comp` socket or `~/.config/openxr/1/active_runtime.json` already exist.
    - I presume it lacks permissions to edit the `active_runtime.json`, so it can't temporarily replace it.
    - For likely a similar reason, it will not remove `monado_ipc_comp` when the server closes, and will fail with `Connection refused!` each time it tries to connect through that socket.
    - This means it also conflicts with my separate WiVRn install, as I have to move/rename its `active_runtime.json` to get Envision running.
- (DNF Package) Envision will fail to start Monado if the `/run/user/1000/monado_ipc_comp` socket already exists.
    - I edited my Envision launch script (which sets my power profile) to also remove this file on launch, and it seems to "just work" for the first time I click Start.
        - It still dies on subsequent Starts until restarting Envision, however.
- On AMD GPUs, ensure the power profile is set to VR, otherwise the view will be VERY jittery. Envision should display a warning box inside its main window if this is not set.
- Head tracking is slightly laggy, perhaps reprojection is not working right?
    - I switched to the Envision Fedora package (instead of the AppImage) and it seems not as bad now as I remember.

### ALCOM ([vrc-get-gui](https://github.com/vrc-get/vrc-get/blob/master/vrc-get-gui/README.md))
- Alternative Creator Companion for VRChat.
- The AppImages now have a white screen. Initially v0.1.15 worked, but some system upgrade must have broken it. v0.1.16 never worked.
    - EGL Display error. Basically identical to [this comment](https://github.com/vrc-get/vrc-get/issues/1694#issuecomment-2480857765) on the white screen issue thread.
- Needed to install DNF packages `nodejs-npm gtk3-devel libsoup3-devel javascriptcoregtk4.1-devel webkit2gtk4.1-devel dotnet-sdk-8.0` and cargo crate `cargo-about`.
- Final step of build fails to bundle the AppImage, but frankly I couldn't care less about using an AppImage. The executable is built in `vrc-get/target/release/` anyway.
    - As long as it says `Built application at: /home/user/.../vrc-get/target/release/ALCOM` you should be all good.
    - Might break some things if it expects to be running as an AppImage, for example the setting `Use ALCOM for vcc: URL Scheme` shows a "failed to get appimage path" error, more remains to be seen.
- No matter which variant of ALCOM I use, launching Unity though ALCOM fails with a "No valid license found" error.
    - For now I just use either of the following:
        - ALCOM for project and package management and Unity Hub just to launch them.
        - Moonlight to a Windows laptop for Unity stuff with the regular Creator Companion, cause Unity doesn't like Wayland much.
    - Unity is a FlatPak, idk if that has anything to do with it.

## Curiosities
Stuff I don't expect to work but try anyway, because why not? Maybe something interesting will happen.

### OVR Toolkit
- Desktop sits on the loading screen indefinitely with the text "Task Scheduler is broken."
- Nothing happens in VR.
- After closing the desktop window, it remains running until closed by other means.
- *I cannot uninstall it through Steam*.

## Untested
Owned and/or willing to test.
- I am Sakuya VR
- Republique VR
- Traffic Jams
- Assetto Corsa
- Through library sharing:
    - Tabletop Simulator
    - The Forest
    - REZ: Infinite
    - Blind
    - Project Cars 2
- Wishlisted:
    - Hyperbolica
    - Sairento VR
    - Ancient Dungeon
    - Endoparasitic VR
    - Metal: Hellsinger VR
    - Hot Dogs, Horseshoes & Hand Grenades
    - Waltz of the Wizard
    - The Tale of Onogoro
    - No Man's Sky
    - BONEWORKS
    - BONELAB
    - Sushi Ben
    - The Walking Dead: Saints & Sinners
