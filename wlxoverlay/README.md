# wlxoverlay

Contained here are the following:
- [aurorasky](aurorasky.dds)
    - The SteamVR void background converted to DDS format, since I wanted a darker skybox and finding a different one turned out to be more effort than it was worth.
- [openxr_actions](openxr_actions.json5)
    - I changed the Oculus controller profile (Oculus/Meta/PICO devices, maybe others)
    - Working Set Toggle - Left Menu
    - Space Drag - Left Joystick click or Right Joystick click.
    - Space Reset - Left Joystick double-click.
    - If chords are ever implemented, I would like to change Space Drag to my old OVRAS config of Grip + Trigger + B/Y Touch.
        - Look, it feels nice to physically "grab" the air to move around, instead of clicking a button.
        - I think of it as B/Y + Trigger to activate, and Grip to Space Drag. If you're holding something, use Trigger or B/Y Touch to drag instead.
- [watch](watch.yaml)
    - Customised watch with a nicer layout and EST/JST clocks instead of Chicago and Tokyo, since timezone codes are much more useful to me than just a city name and having to remember what timezone it is.
        - EST specifically for [No Friends Friends Club](https://vrc.group/NFFC.9364) (NFFC) events.
    - Date format is DD/MM/YY.
    - Includes a WayVR button that spawns the [waywatch](waywatch.yaml) overlay.
- [waywatch](waywatch.yaml)
    - Little overlay with 3 rows of WayVR application lists and a close button.
    - Was supposed to be a watch but idk if I can attach it to a hand automatically.
- [wayvr](wayvr.yaml)
    - My placeholder WayVR config. Since I use KDE, I have their apps set up for the moment.
    - Contains mostly broken launchers for things like Firefox, osu, and OBS.
        - They technically run, but don't appear on-screen.
    - Working shortcuts:
        - Radeontop and htop spawn on the right hand.
        - Kwrite, Terminal, and fastfetch share a window. Fastfetch exits on its own.
        - Dolphin has its own window.