# linux-vr-compat
Testing VR games on my Linux setup with WiVRn and WlxOverlay.

## Setup

### Software
- Fedora 41 (KDE Plasma, Wayland)
- WiVRN to connect to the headset and emulate SteamVR.
- WlxOverlay for desktops and playspace drag.
    - Space Drag is either stick click, Space Reset is double-click left stick.
    - Custom build with battery OSC parameters, see my repos for more info on that.
- Most games run through Steam, SteamVR is not installed. Using launch arguments provided by WiVRn to make games use it as the VR runtime.
- Proton: GE-Proton9-18 (unless otherwise specified)

### Hardware
- AMD Ryzen 5 5600G
- AMD RX 6600XT 8GB
- 16GB RAM (2x8GB, 3200Mhz, DDR4)
- Everything installed on a hard drive. (including OS)
- PICO 4 headset, connected with USB 3.0.
    - Currently, WiVRn has incorrect controller offsets for PICO 4 controllers. Status on that is [completed](https://github.com/WiVRn/WiVRn/issues/94) but a release has yet to be made.

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
- Resonite (Proton, [see here](https://lvra.gitlab.io/docs/resonite/))
    - Logged in, froze when loading my cloud home while in the tutorial, so it may not like changing worlds.
        - My cloud home is the default cloud home transferred from Neos, so world complexity/heaviness may not be the issue.
    - Default stick-click to jump binding conflicts with my space-drag/reset bindings.
- ChilloutVR
- Down the Rabbit Hole
- Propagation VR

## Partially working
These launch, but are unplayable.
- Tea For God
    - Hands don't appear, so cannot interact with anything.
    - This setup doesn't provide a playspace at all, so only joystick locomotion is available.
- Slinger VR
    - Hands are stuck at the playspace origin.
- Aperture Hand Lab
    - Hand tracking is unusable due to lacking buttons, and uses Knuckles-style curls instead of the proper hand skeleton.
    - Teleport binding is awkwardly mapped to stick click, and doesn't seem to confirm teleport on release.
    - Playable with controllers up until the handshake bot due to lacking a grip pressure sensor.
        - This could be simulated using the grip analogue (say, the last 5-10%), but it will never be true pressure on current non-Knuckles controllers.

## Not working
The following crash on launch or have other major issues.
- Zenith VR
    - Loading screens are broken.
    - Crashes immediately after rendering the first loading screen with a texture error.
    - Using GE-Proton7-55 seems to give a different texture error, at least a different style of error window.
- Until You Fall
    - Black screen after logo, black-screen-fix beta no longer exists?
    - Using GE-Proton7-55 changes nothing.
- Half-Life 2 VR
    - Launches, but can't find VR session.
- Hyper Dash
    - Fails to launch with an OpenComposite error for a stubbed file related to the chaperone.
    - This also has a free standalone version on both PICO and Quest, so not too big a deal in this scenario.
- Vivecraft (Non-Steam game)
    - Version: 1.20.1-1.1.14-fabric on Quilt Loader
    - Fails to locate installation path, presumably for SteamVR.
        - According to [the FAQ](https://www.vivecraft.org/faq/#opencomposite), Vivecraft supports OpenComposite, but I'm not sure how to get it to find it or if recent updates (such as moving to Fabric) broke things.
- Project Cars
    - Doesn't create a window, crashes shortly after Steam stops saying loading.
- Museum of Other Realities
    - Crashes with a texture error after rendering the first logo, like Zenith.

## Untested
Owned and willing to test.
- I am Sakuya VR
- Desert Bus VR
- Republique VR
- Traffic Jams

## Curiosites
Stuff I don't expect to work but try anyway.
- OVR Toolkit
    - Desktop sits on the loading screen indefinitely with the text "Task Scheduler is broken."
    - Nothing happens in VR.
    - After closing the desktop window, it remains running until closed by other means.

