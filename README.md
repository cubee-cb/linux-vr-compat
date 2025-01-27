Testing VR games with WiVRn and WlxOverlay-S.
Other files include scripts or configs that I use.

**Note**: Lately `amdgpu` has been encountering page faults and subsequent GPU resets for some systems, including mine.
It looks to be related to `linux-firmware` and video encoding/decoding on AMD GPUs, and in my experience typically occurs when using WiVRn, though it does happen outside of VR on occasion.
Seems to be tracked here:
- [ring vcn_enc_0.0 timeout cause by linux-firmware 20241210.b00a7f7e](https://gitlab.freedesktop.org/drm/amd/-/issues/3842)
- ~[Full OS crash when using media source](https://gitlab.freedesktop.org/drm/amd/-/issues/3855)~ merged with above.

Notably, it seems to occur less frequently whenever I make a large change to my system such as moving Fedora to my SSD instead of my HDD, or downgrading `linux-firmware`, but it always becomes unplayable again within a few days.

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
- Most games installed on a hard drive. Recently migrated OS to SSD (that was painful).
- PICO 4 headset, with USB 3.0 cable.
    - ~Currently, I still have incorrect controller offsets for PICO 4 controllers. Supposedly it was fixed in WiVRn v0.22, and indeed they look correct in the WiVRn client menu and WlxOverlay-S, but they still have the wrong offsets in OpenComposite applications.~ This seems fine for some VRChat avatars now, no idea how anything changed since WiVRn hasn't been updated since then, and some games' offsets still are incorrect?
    - Hand tracking works fine in titles that support it. Make sure it's enabled at the system level to turn it on in WiVRn. (Settings > Lab > Hand Tracking)
    - Presence sensor isn't used, so VRChat doesn't trigger AFK, Vivecraft won't hotswitch, etc.
- Windows Mixed Reality HP VR1000-122a.

### Software
- Fedora 41 (KDE Plasma, Wayland)
- [WiVRn](https://github.com/WiVRn/WiVRn) (Flatpak v0.22) to connect to the PICO 4 and emulate SteamVR via OpenComposite.
    - Lately my tracking seems to vary between perfect, very jittery, or overly smoothed. Closing the WiVRn client and reconnecting seems to choose a random variation.
- [Envision](https://gitlab.com/gabmus/envision) with WMR profile.
    - Mostly functional. Reprojection is laggy. [Has other issues](#developmenthardware).
- [WlxOverlay-S](https://github.com/galister/wlx-overlay-s) for desktop views and playspace drag.
    - Space Drag is either left/right stick click, Space Reset is double-click left stick.
    - Custom build with battery OSC parameters, this has been [merged with main](https://github.com/galister/wlx-overlay-s/pull/108) as of now but has yet to be included in a release.
- Most games run through Steam (Runtime), SteamVR is not installed. Using launch arguments provided by WiVRn to make games use it as the VR runtime. Manually. For each game individually. (there's probably a more efficient way to do it other than switching to Envision for both headsets)
- Proton: [GE-Proton9-18](https://github.com/GloriousEggroll/proton-ge-custom/releases/tag/GE-Proton9-18) (unless otherwise specified)

---

## Working
Things we can actually play! Yay!

^ - Using a different Proton version. (notes will mention why)

---

### ^ VRChat
- Updated to GE-Proton9-20-rtsp16 to hopefully fix video players being weird again, and since RTSP is the [recommended fork for VRChat](https://lvra.gitlab.io/docs/vrchat/#recommended-proton). GE-Proton9-18 works fine otherwise.
- World "Connecting" screens are broken, known OpenComposite quirk.
- Uses [gamemoderun](https://github.com/FeralInteractive/gamemode) and custom start script from [Linux VR Adventures Wiki](https://lvra.gitlab.io/docs/vrchat/eac/).
    - idk if the start script helps much though.
- Terrors of Nowhere
    - [ToN Save Manager](https://github.com/ChrisFeline/ToNSaveManager) runs via [Protontricks](https://github.com/Matoking/protontricks) inside the VRChat prefix (appid 438100).
        - See [the VRChat folder](vrchat/launch-ton-save-manager.sh) for an example launch script using flatpak Protontricks.
        - Seems to work fine. Finds save files in the logs, saves copy when clicked, and even OSC works.
            - You can test OSC with [Rin the Witch](https://vrchat.com/home/avatar/avtr_0ae41d3f-ae4a-437d-b429-4b1dbb217d20) from Spookality 2024. The gold on her outfit should change colour to match the Terror's colour shown in the UI. Use the HSV colours setting.
- Sometimes launching in VR bombards me with Anti-Cheat errors, despite using the start script. These errors actually have text though, saying the files failed to verify, and may also be related to the system being overloaded while starting. Perhaps this was due to a HDD bottleneck, notably this hasn't yet occured since moving my OS and VRChat to an SSD.
- Videos on video players get stretched, while on PICO Standalone and Windows they get letterboxed.
    - Exhibited on ProTV 3 in [my home world](https://vrchat.com/home/launch?worldId=wrld_f79b0387-d681-409a-bbe8-4a40cc8528ce).

### ^ Beat Saber (Modded) ([Video](https://youtu.be/ESWKezEggIg&t=65))
- Modding with [Beat Saber Mod Manager](https://github.com/affederaffe/BeatSaberModManager).
    - Settings and selected mods do not save on v0.0.6, use v0.0.5 instead.
- Mods do not load with GE-Proton9-18, but do with Proton Experimental.

### Pistol Whip ([Video](https://youtu.be/ESWKezEggIg&t=754))
- First launch took ages, but otherwise works perfectly.

### VAIL
- Works despite the addition of Denuvo anti-cheat in patch 1.2.4.
- Default bindings have fire on trigger touch rather than trigger pull, which makes it pretty annoying to play.
    - I've managed to obtain a bindings file from the `steamapps/workshop/` folder for SteamVR on another device, but I can't seem to get OpenComposite to pick it up. ([LVRA Wiki](https://lvra.gitlab.io/docs/fossvr/opencomposite/))
    - I have tried [XRBinder](https://lvra.gitlab.io/docs/fossvr/xrbinder/), but can't get it to detect anything other than WlxOverlay-S one time.
- Menus are very flickery.
- Large stutters while loading maps, likely due to running on a hard drive.

### Rec Room
- Alpha on the EAC window is broken, causing black squares.
- The game will fail to login with error code "wrapper" unless you install "Proton Easy Anti Cheat Runtime" through Steam.
    - ~This may affect VRChat, however. See VRChat's section above.~ May be a coincidence? VRChat still has problems after removing it.
- After logging in the first time, an OpenComposite window appeared simply saying "An error has occured". Subsequent launches seem to go smoothly.
- Loading screens are broken a la VRChat, but the game itself looks fine.

### ^ Ragnarock ([Video](https://youtu.be/ESWKezEggIg&t=1048))
- Successfully launches with GE-Proton7-55. Fails to launch with D3D11 error on GE-Proton9-18.
- Hammer/drum offsets seem to get stuck changing when adjustments are made, even when the joystick is released.

### ^ Into the Radius ([Video](https://youtu.be/ESWKezEggIg&t=2202))
- Successfully launches with GE-Proton7-55. Fails to launch with D3D11 error on GE-Proton9-18.
- Extremely blurry by default, had to increase in-game resolution scale and turn off TAA.

### Hellblade: Senua's Sacrifice VR Edition
- HMD view only. Requires a standard controller.
- First launch crashed on starting a new game. Subsequent launch was fine, however.
- A certain cutscene near the start of the game has Senua's head clip through the cutscene border and into the camera, which was fairly weird to experience.

### Catlateral Damage VR
- Linux native doesn't support VR, use Proton if you want to try the VR mode. Requires the free VR DLC installed.
- Desktop mode under Proton has a lot of input lag, but VR is purrfect.
- This game apparently binds Turn Right to both right *and left* joystick click, even on Windows+SteamVR. Not ideal, but it's also a problem with the game, not OpenComposite.
    - Teleport is mapped to trigger.
    - Meow is mapped to right grip. (the most important mapping of all!)
    - Continue is mapped to left Y, which isn't obvious with the OpenComposite rendermodels being actual hands.
    - Click either joystick on the title scene to change cat colours.

### I am Sakuya VR ([Video](https://youtu.be/cheXlFRxugk))
- A little stuttery but mostly playable.
- The level "To the top of the mansion" has the player clip into the floor as it rises and is very jittery as a result.
- This game has weird controller offsets even on Windows/SteamVR; here the game hands are positioned above the real controllers.
- HUD is just barely in vision but too small to be readable. (might be settings to adjust it though, haven't looked)

### The Lab ([Video](https://youtu.be/TEen2J73evQ?t=0))
- Loading screens are broken.

### Rumble ([Video](https://youtu.be/ESWKezEggIg&t=2912))
- Desktop window complains that the wrong OpenXR runtime is being used, but ignore that and it seems to work fine.

### Keep Talking and Nobody Explodes
- Linux native doesn't support VR, use Proton instead.

### Vertigo: Remastered

### Vacation Simulator ([Video](https://youtu.be/ESWKezEggIg&t=1470))

### SUPERHOT VR (Pre-removed scenes version via depot download)

### ChilloutVR

### Sushi Ben Demo ([Video](https://youtu.be/TEen2J73evQ?t=1284))

### Down the Rabbit Hole

### Propagation VR

### [Beat Saber Origins](https://hyperbolicmagnetism.itch.io/beat-saber-origins) (via [Heroic Games Launcher](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher))
- Works perfectly. I just used Heroic because I had it installed for my Epic and GOG games.
- Setup:
    - Add the executable to Heroic through the Add Game button. Use Proton-GE-9-18, as Wine-GE-Proton doesn't support VR.
    - Add WiVRn's `PRESSURE_VESSEL` environment variable to Heroic's game settings (Advanced tab)

### ^ Kart Racing Pro rel13e non-Steam ([Video of rel11b](https://youtu.be/zWL9ZwvFJ5A)) (via Steam or [Heroic Games Launcher](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher))
- HMD view only. Requires a standard controller/wheel.
- Playable, flickery shadows. Black screen in VR until starting an actual race, so use WlxOverlay-S to interact with menus.
- Setup:
    - Add the executable to Steam or Heroic through the Add Game button. Use Proton-GE-7-55, as the game fails to launch with Proton-GE-9-18 and Wine-GE-Proton doesn't support VR.
    - Add the `-vr` launch option and WiVRn's `PRESSURE_VESSEL` environment variable to Steam's Launch Options or Heroic's Advanced tab.

---

## Partially working
These launch, but are unplayable or have serious issues functioning.
Or, in some cases they start working all of a sudden but I have no idea why.

---

### Half Life: Alyx
- Ok, this is a weird one. I built OpenComposite manually, and now regardless of which version I use (WiVRn or Built):
    - Proton Version: Used to work, but now it crashes after the grey Valve logo.
        - Crashes on launch with no error window. This is basically what Native did beforehand.
    - Native Version: Used to crash on launch, but now it does work???
        - Now the left joystick controls movement properly, but performance is abysmal (10-15fps) and stutters horribly.
        - Launch options: `PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/wivrn/comp_ipc:/var/lib/flatpak/app/io.github.wivrn.wivrn %command% -novid -console -vconsole +vr_fidelity_level_auto 0 +vr_fidelity_level 3`
            - iirc this disables the Valve intro scene and turns off dynamic resolution, which I believe caused the white bars in the edges of the FoV mentioned later.
- Old info (still generally applies):
    - Controller bindings are somewhat broken:
        - A and X are snap turn right/left respectively. A is also the reload action.
        - Left joystick seems to do nothing (on Proton), but right stick turns and does teleport/jump as normal.
        - Weapon selection on joystick click conflicts with my space drag binding.
    - On second launch I found that after loading into my save there was a white bar across the bottom and right sides of the rendered display, only visible due to reprojection.
        - Perhaps the dynamic resolution is broken? [This seems to help](https://www.pcgamingwiki.com/wiki/Half-Life:_Alyx#Disable_dynamic_resolution_scaling).

### Vivecraft
- Running through Prism Launcher (Flatpak), with Vivecraft 1.21.1-1.2.2-fabric on Quilt Loader.
- Set Flatpak allowed paths according to Issac Dowling's [message in the LVRA Discord](https://discord.com/channels/1065291958328758352/1065291958794322012/1297896737624690741) or [YouTube video](https://www.youtube.com/watch?v=o8ho7VG13Ck&t=530s) to allow it to talk to WiVRn.
- Some buttons get stuck pressed until opening the pause menu. (e.g. A place block, LS jump, RS sneak)
    - Notably, certain buttons don't seem to get stuck. (X inventory, Y pause, B radial menu)
    - I see mention on the LVRA Discord of both an OpenXR version of Vivecraft and a branch of OpenComposite that "fixes" OpenVR Vivecraft, so I may look into those to see if either of them fix the "sticky" controls.
- Hotswitching doesn't work since some part of the chain doesn't read the presence sensor.
- I tested Modrinth Launcher initially, but I couldn't get that working. Since Prism also supports Modrinth instances this is overall much better.

### ^ Resonite (Proton, [see here](https://lvra.gitlab.io/docs/resonite/))
- As recommended on the linked page, switched to GE-Proton9-20-rtsp16.
- Default stick-click to jump binding conflicts with my space-drag/reset bindings. Need to figure out how to rebind it to match WMR's bindings better.
- My performance is abysmal and I often freeze when connecting to sessions, so for now I've demoted its status.
    - This may be due to running off a hard drive, I'll revisit this and add a note if running off an SSD fixes it.

### Assetto Corsa
- Launcher does not support VR. Track menus support VR controllers, but gameplay may require a standard controller/wheel.
- Won't interface with VR until starting an actual race, so use WlxOverlay-S to interact with the launcher.
- Vanilla launcher:
    - Launches in VR when SteamVR mode is selected in the graphics settings.
    - WiVRn PICO 4 view is placed at seat level. Press Q+E (both look left and look right bindings) to recentre view.
        - When using controllers, the driver hands aren't positioned correctly.
        - When using Hand Tracking, the driver hands float several metres above the car with the arms stretched to reach them.
    - Envision WMR view is positioned correctly by default.
        - Hand tracking places the controller points correctly, but the driver hands do not follow them.
- Content Manager:
    - Fails to find VR.
        - Envision doesn't need the Steam environment variable like standalone WiVRn does, so that likely rules out environment variable passthrough.
        - Content Manager specifically has a setting for OpenComposite, which is all the more strange why it doesn't work.
        - Someone mentioned `I think I read something about disabling some parts of CSP , but not sure where to start there is a lot!`: [LVRA Discord message](https://discord.com/channels/1065291958328758352/1225819663024259082/1313565712035348553)
    - Content Manager not working in VR is the reason this is placed in Partially Working.

### GRIP
- HMD view only. Requires a standard controller/wheel.
- Plays perfectly... until it crashes mid-race.
    - Roughly: `Assertion failed: Wine C++ Runtime Library > /src-vrclient/winIVRSystem.c Line 8701 expression "!status"`, then `Fatal Error`.
- Splash screens are displayed on the desktop, but once in the game menus it switches to VR.
- Desktop mode seems to work.
- Using GE-Proton7-55 seems to prevent the Wine error window from appearing, however it does not stop the crashing nor the `Fatal Error` window.

### COMPOUND Demo
- Previously had an OpenComposite error every launch due to generated Microsoft Holographic (WMR) bindings missing the "none" action.
- Manually built OpenComposite, now it just works, both with the built version set as `VR_OVERRIDE` and when using WiVRn's bundled version.
    - idk why this has happened so it's in this section for now.

### Metal: Hellsinger VR Demo
- Starts and stays on a black screen. May need longer for initial load like Pistol Whip, hence being placed here instead of Not working.
- The game's custom cursor appears on the desktop window and can be moved around.

### Tea For God
- Hands don't appear, so cannot interact with anything.
- This setup doesn't provide a playspace at all, so only joystick locomotion is available.
    - Maybe [LOVR Playspace](https://lvra.gitlab.io/docs/fossvr/lovr/lovr-playspace/) could help with this, if it actually creates a playspace and isn't just visual.

### Aperture Hand Lab
- Teleport binding is awkwardly mapped to stick click, and doesn't seem to confirm teleport on release.
- Playable with controllers up until the handshake bot due to lacking a grip pressure sensor. Hand tracking has no buttons and so it's unusable here.
    - This could be simulated using the grip analogue (say, the last 5-10%), but it will never be true pressure on current non-Knuckles controllers.

### Kingspray Graffiti
- Might work, but takes ages to load into a map. I gave up waiting.
- Again, might be related to HDD speed.

### Slinger VR
- Controllers are stuck at the playspace origin and don't respond to input.

### Tabletop Simulator
- Crashes on launch with a stubbed file error. `.../Reimpl/BaseInput.cpp:569: SetActionManifestPath`

---

## Not working
The following crash on launch or have other major issues.

---

### Zenith VR ([Video](https://youtu.be/ESWKezEggIg&t=1392))
- Loading screens are broken.
- Crashes immediately after rendering the first loading screen with a texture error.
- Using GE-Proton7-55 doesn't help.

### Until You Fall ([Video](https://youtu.be/ESWKezEggIg&t=1975))
- Black screen after logo, black-screen-fix beta no longer exists?
- Using GE-Proton7-55 changes nothing.

### Half-Life 2 VR ([Video](https://youtu.be/ESWKezEggIg&t=1304))
- Launches, but fails to find the VR session.
- People in the LVRA Discord mentioned using a 32-bit build of WiVRn and OpenComposite. I'll keep an eye on that.

### Project Cars
- Doesn't create a window, crashes shortly after Steam stops saying loading.

### Hyper Dash ([Video](https://youtu.be/ESWKezEggIg&t=2086))
- Fails to launch with an OpenComposite error for a stubbed file related to the chaperone.
- This also has a free standalone version on both PICO and Quest, so not too big a deal in this scenario.

### Legend of Dungeon
- Linux native lacks the VR mode launch option on both live and beta.
- Proton+live has an old VR option that supposedly doesn't work, didn't bother testing.
- Proton+beta has SteamVR option, but it launches in desktop mode.

### Museum of Other Realities
- Crashes with a texture error after rendering the first logo, like Zenith.
- Using GE-Proton7-55 doesn't help.

### Desert Bus VR
- Launches in desktop mode even when choosing the SteamVR launch option.

---

## Development/hardware
Troubleshooting setup of hardware or build issues.

---

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
- Can't figure out how to disable hand tracking. It's cool and all, but makes some games unplayable (like VRChat) since they then expect VR-style controllers instead of a standard controller, and the hand tracking is jittery to the point of being unusable.

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

---

## Curiosities
Stuff I don't expect to work but try anyway, because why not? Maybe something interesting will happen.

---

### OVR Toolkit
- Desktop sits on the loading screen indefinitely with the text "Task Scheduler is broken."
- Nothing happens in VR.
- After closing the desktop window, it remains running until closed by other means.
- In order to uninstall it (Steam kept re-installing it), I had to close Steam entirely, delete the folder, then remove OVR Toolkit's `appmanifest.acf` from `steamapps`.

### OyasumiVR
- Fails to install Edge WebView2. Cannot launch without it.

### Trinus Cardboard VR (via Heroic)
- "Unexpected UI Error" appears after the "Enter the Trinus" splash. Pressing Ignore allows the main window to open.
- Connecting to the phone works, window capture worked for the Trinus window itself the first time, mouse control works.
- Opening the LED position tracker test crashes Trinus.

---

## Untested
Owned and/or willing to test.

---

- Republique VR
- Traffic Jams
- The Forest
- REZ: Infinite
- Blind
- Project Cars 2
- Wishlisted:
    - Hyperbolica
    - COMPOUND
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
