# linux-vr-compat
Testing VR games on my Linux setup with WiVRn and WlxOverlay.

## Setup

### Software
- Fedora 41 (KDE Plasma, Wayland)
- WiVRN (Flatpak) to connect to the headset and emulate SteamVR via OpenComposite.
- WlxOverlay for desktop views and playspace drag.
    - Space Drag is either stick click, Space Reset is double-click left stick.
    - Custom build with battery OSC parameters, this has been [merged with main](https://github.com/galister/wlx-overlay-s/pull/108) as of now but has yet to be included in a release.
- Most games run through Steam (Runtime), SteamVR is not installed. Using launch arguments provided by WiVRn to make games use it as the VR runtime. Manually. For each game individually. (there's probably a more efficient way to do it)
- Proton: GE-Proton9-18 (unless otherwise specified)

### Hardware
- AMD Ryzen 5 5600G
- AMD RX 6600XT 8GB
- 16GB RAM (2x8GB, 3200Mhz, DDR4)
- Everything installed on a hard drive. (including OS)
    - Plan to move to an SSD at some point, but loading speeds aren't bad! Or maybe I'm just used to it?
- PICO 4 headset, connected with USB 3.0.
    - Currently, WiVRn has incorrect controller offsets for PICO 4 controllers. Status on that is [completed](https://github.com/WiVRn/WiVRn/issues/94) but a release has yet to be made.
    - Hand tracking works fine in titles that support it, and has correct offsets unlike the controllers.
        - The enable option will be greyed out on the HMD unless hand tracking is enabled at the system level. (Settings > Lab > Hand Tracking)
        - If I get the PICO Motion Trackers, I may look into trying to implement support for them myself. I really have no idea what I'm doing though, so don't hold your breath.
    - On Windows, whenever I used ALVR I would somewhat regularly get connection time outs, even over USB. Interruptions have only occured on WiVRn thus far if my system is dramatically overloaded. Thanks Windows!

## Working
Things we can actually play! Yay!

^ - Requires a different Proton version.

- VRChat
    - World "Connecting" screens are broken.
    - Uses [gamemoderun](https://github.com/FeralInteractive/gamemode) and custom start script from [Linux VR Adventures Wiki](https://lvra.gitlab.io/docs/vrchat/eac/).
    - Terrors of Nowhere
        - [ToN Save Manager](https://github.com/ChrisFeline/ToNSaveManager) runs via [Protontricks](https://github.com/Matoking/protontricks) inside the VRChat prefix (appid 438100).
            - See the VRChat folder for a launch script using flatpak Protontricks.
            - Seems to work fine. Finds save files in the logs, saves copy when clicked, and even OSC works.
    - Interestingly, a while after going AFK my avatar stands up. Looks kind of silly.
    - Every first launch of the day will produce rapid in-game anticheat errors for each file of the game, saying it couldn't validate them. Subsequent launches are fine. Investigation ongoing.
- Beat Saber
    - Modding with [Beat Saber Mod Manager](https://github.com/affederaffe/BeatSaberModManager).
        - Settings and selected mods do not save.
    - Mods do not load with GE-Proton9-18, but do with Proton Experimental.
- Pistol Whip
    - First launch takes ages, but otherwise works perfectly.
- The Lab
    - Loading screens are broken.
- Sushi Ben Demo
- ^ Ragnarock
    - Successfully launches with GE-Proton7-55. Fails to launch with d3d11 error on latest.
    - Hammer/drum offsets seem to get stuck changing when adjustments are made, even when the joystick is released.
- ^ Into the Radius
    - Successfully launches with GE-Proton7-55. Fails to launch with d3d11 error on latest.
    - Extremely blurry by default, had to increase in-game resolution scale and turn off TAA.
- Vacation Simulator
- Rumble
    - Desktop window complains that the wrong OpenXR runtime is being used, but ignore that and it seems to work fine.
- VAIL
    - Shockingly works, despite the recent addition of Denuvo anti-cheat in patch 1.2.4 on 3 October 2024.
    - Default bindings have fire on trigger touch rather than pull.
        - I've managed to obtain a bindings file from the `steamapps/workshop/` folder for SteamVR on another device, but I can't seem to get OpenComposite to pick it up. ([LVRA Wiki](https://lvra.gitlab.io/docs/fossvr/opencomposite/))
        - I might try [XRBinder](https://lvra.gitlab.io/docs/fossvr/xrbinder/) in the future to see if that has any more success.
    - Menus are very flickery some of the time.
    - Large stutters while loading maps, though likely due to running on a hard drive.
- ChilloutVR
- Down the Rabbit Hole
- Propagation VR
- Rec Room?
    - Wait, Rec Room has EAC??
        - Alpha on the EAC window is broken, causing black squares.
    - Launches perfectly fine, but gives error code "wrapper" which effectively just means EAC broke.
        - Installing "Proton Easy Anti Cheat Runtime" through Steam then allows the game to log in.
    - After logging in the first time, an OpenComposite window appeared simply saying "An error has occured". Subsequent launches seem to go smoothly.
    - Loading screens are broken a la VRChat, but the game itself looks fine as opposed to what some people have been saying for Rec Room on OpenComposite.
    - Rec Room, hire me so I can fix all the broken weights in your outfits, the Aviator Gloves have like 3 verts weighted wrong each.
- SUPERHOT VR
    - Tested the version without removed scenes via depot download. (assuming that the depot command was correct, haven't played far enough yet)
- Hellblade: Senua's Sacrifice VR Edition
    - First launch crashed on starting a new game. Subsequent launch was fine, however.
    - No VR controller support; must use a controller or keyboard. This is just a VR view of the standard game after all.
    - A certain cutscene near the start of the game has Senua's head clip through the cutscene border and into the camera, which was fairly weird to experience.

## Partially working
These launch, but are unplayable or have serious issues functioning.
- Tea For God
    - Hands don't appear, so cannot interact with anything.
    - This setup doesn't provide a playspace at all, so only joystick locomotion is available.
- Slinger VR
    - Controllers are stuck at the playspace origin and don't respond to input.
- Aperture Hand Lab
    - Hand tracking is unusable due to lacking buttons, and uses Knuckles-style curls instead of the proper hand skeleton.
    - Teleport binding is awkwardly mapped to stick click, and doesn't seem to confirm teleport on release.
    - Playable with controllers up until the handshake bot due to lacking a grip pressure sensor.
        - This could be simulated using the grip analogue (say, the last 5-10%), but it will never be true pressure on current non-Knuckles controllers.
- Resonite (Proton, [see here](https://lvra.gitlab.io/docs/resonite/))
    - Logged in, froze when loading my cloud home while in the tutorial, so it may not like changing worlds.
        - My cloud home is the default cloud home transferred from Neos, so world complexity/heaviness may not be the issue.
    - Default stick-click to jump binding conflicts with my space-drag/reset bindings.
    - My performance is abysmal and I often freeze when connecting to sessions, so for now I've demoted its status.
        - This may be due to running off a hard drive, I'll revisit this and add a note if running off an SSD fixes it.
- GRIP
    - Plays perfectly with a traditional controller... until it crashes mid-race.
        - `Assertion failed: Wine C++ Runtime Library > /src-vrclient/winIVRSystem.c Line 8701 expression "!status"`, then `Fatal Error`.
        - Seems like it's a VR-specific error for running under Wine/Proton. That's a shame.
    - Splash screens are displayed on the desktop, but once in the game menus it switches to VR.
    - Desktop mode seems to work.
    - Using GE-Proton7-55 seems to prevent the Wine error window from appearing, however it does not stop the crashing nor the `Fatal Error` window.
- Metal: Hellsinger VR Demo
    - Starts and stays on a black screen. May need longer for initial load like Pistol Whip, hence being placed here instead of Not working.
    - The game's custom cursor appears on the desktop window and can be moved around.
- Half Life: Alyx (Proton)
    - Launches, menu interaction works, can load into a save file.
    - Controller bindings are broken:
        - A and X are snap turn right/left respectively. A is also the held item secondary action (like shotgun reload)
        - Left joystick seems to do nothing, right stick only turns (no teleport/jump)
        - Weapon selection button conflicts with my space drag binding.
        - To be fair I've only played this on WMR so I have no idea what the controls are supposed to be like.
- Kingspray Graffiti
    - Might work, but takes ages to load into a map. I gave up waiting.
    - Again, might be a HDD-related speed problem.

## Not working
The following crash on launch or have other major issues.
- Zenith VR
    - Loading screens are broken.
    - Crashes immediately after rendering the first loading screen with a texture error.
    - Using GE-Proton7-55 doesn't help.
- Until You Fall
    - Black screen after logo, black-screen-fix beta no longer exists?
    - Using GE-Proton7-55 changes nothing.
- Half-Life 2 VR
    - Launches, but can't find VR session.
- Hyper Dash
    - Fails to launch with an OpenComposite error for a stubbed file related to the chaperone.
    - This also has a free standalone version on both PICO and Quest, so not too big a deal in this scenario.
- Vivecraft (Non-Steam game)
    - Running through Modrinth Launcher
    - Version: 1.20.1-1.1.14-fabric on Quilt Loader
    - When entering VR mode it fails to locate installation path, presumably for SteamVR.
        - According to [the FAQ](https://www.vivecraft.org/faq/#opencomposite), Vivecraft supports OpenComposite, but I'm not sure how to get it to find it or if recent updates (such as moving to Fabric) broke things.
        - Providing environment variables according to [this video from Issac Dowling] to allow Modrinth Launcher to talk to WiVRn doesn't seem to change anything, though I may have made a mistake somewhere.
- Project Cars
    - Doesn't create a window, crashes shortly after Steam stops saying loading.
- Museum of Other Realities
    - Crashes with a texture error after rendering the first logo, like Zenith.
    - Using GE-Proton7-55 doesn't help.
- Half Life: Alyx (Native)
    - Crashes on launch with no error window.
- COMPOUND
    - OpenComposite error due to generated Microsoft Holographic (WMR) bindings missing the "none" action. Probably solvable.

## Untested
Owned and/or willing to test.
- I am Sakuya VR
- Desert Bus VR
- Republique VR
- Traffic Jams
- Through library sharing:
    - Tabletop Simulator
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

## Curiosites
Stuff I don't expect to work but try anyway, because why not? Maybe something fun will happen.
- OVR Toolkit
    - Desktop sits on the loading screen indefinitely with the text "Task Scheduler is broken."
    - Nothing happens in VR.
    - After closing the desktop window, it remains running until closed by other means.

