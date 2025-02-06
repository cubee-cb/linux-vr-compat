# wlxoverlay

Contained here are the following:
- [watch](watch.yaml)
    - Customised watch with a nicer layout and EST/JST clocks instead of Chicago and Tokyo, since timezone codes are much more useful to me than just a city name and having to remember what timezone it is.
        - EST specifically for [No Friends Friends Club](https://vrc.group/NFFC.9364) (NFFC) events.
        - 
    - Includes a WayVR Dashboard button, that when middle-clicked also spawns my old no-longer-functional [waywatch](waywatch.yaml) overlay.
      - Was a little overlay with 3 rows of WayVR application lists and a close button.
      - Was supposed to be a watch but idk if I can attach it to a hand automatically.
      - Lists are `catalog_row1`, `catalog_row2`, and `catalog_row3`.
    - Also has 2 extra OSC buttons for use with WlxOverlay-S versions up to date with current main:
      - The blue `>_` button (Chat) spawns my [quickchat.yaml overlay](quickchat.yaml), which has some sample quick-chat messages for use with the VRChat chatbox. Right-clicking it spawns the [osctoys.yaml](osctoys.yaml) overlay instead, which currently only has a close button.
      - The red `~` button (Disconnect) triggers my [ALVRConnectionOSC](https://github.com/cubee-cb/vr-utils?tab=readme-ov-file#alvrconnectionosc) parameter. Right click resets it. This one's mostly just for testing.
- [timezones.yaml](timezones.yaml)
  - Doesn't seem to work, my watch just uses the default timezones. Are they not valid?
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
