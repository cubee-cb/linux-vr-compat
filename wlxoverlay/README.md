# wlxoverlay

Contained here are the following:
- [watch](watch.yaml)
    - Customised watch with a nicer layout and custom clocks.
        - It's built around the Lexend font, so it may not look quite right with the default font.
    - Includes a button for the WayVR Dashboard.
      - When middle-clicked, it spawns my old no-longer-functional [waywatch](waywatch.yaml) overlay.
    - There are some media controls in the top right, which rely on `playerctl`. There are buttons for play/pause, next, and previous.
    - The blue `>_` button spawns the following:
      - (Blue laser) A [performance monitor panel](monitor.yaml), which shows some values grabbed from a script. [This `pollhw` script](pollhw.sh), to be precise, which has variables that will need to be set up based on your system's hardware.
      - (Orange laser) A [quickchat panel](quickchat.yaml), which has some simple quick-chat messages for use with the VRChat chatbox.
    - The Number button Changes the playspace drag multiplier. Blue laser increases by `1`, Orange laser decreases by `1`.
- [conf.d](conf.d)
  - Includes config files for timezones, font, passthrough, skybox, notification sound ([#179](https://github.com/galister/wlx-overlay-s/pull/179)), and screen display names ([#253](https://github.com/galister/wlx-overlay-s/pull/253)).
- [aurorasky](aurorasky.dds)
    - A SteamVR Void background converted to DDS format, since I wanted a darker skybox and finding a different one turned out to be more effort than I could be bothered putting in when this one was already perfect.
- [openxr_actions](openxr_actions.json5)
    - I changed the Oculus controller profile (Oculus/Meta/PICO devices, maybe others)
    - Show/Hide Working Set - Left Menu
    - Space Drag - Left Joystick click or Right Joystick click.
    - Space Reset - Left Joystick double-click.
    - If OpenXR chords are ever implemented, I would like to change Space Drag to my old OVRAS config of Grip + Trigger + B/Y Touch.
        - It feels nice to physically "grab" the air to move around, instead of clicking a button. Also, this reduces wear on the joystick.
        - I think of it as B/Y + Trigger to activate, and Grip to Space Drag. If you're holding something, use Trigger or B/Y Touch to drag instead.
