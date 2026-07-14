# wayvr

My theme and watch layout for WayVR.

![Example image of the theme and watch.](theme-example.jpeg)

Contained here are the following:
- [conf.d](conf.d) contains my settings. You can skip this if you're happy with your own settings.
- [theme](theme) contains my watch layout and windows:
  - Icon paths are relative to this `theme` directory.
  - Watch:
    - `wpctl` is used for the Volume controls.
    - `playerctl` is used for Media controls.
  - [quick-chat panel](theme/gui/quick-chat.xml)
    - A button panel that sends messages to VRChat's Chatbox. ([#388](https://github.com/wlx-team/wayvr/pull/388)).
- [sound](sound) has some custom sounds I made. ([#379](https://github.com/wlx-team/wayvr/pull/379))
- [palettes](palettes) has my purple and green colour palette.
- [openxr_actions](openxr_actions.json5) contains modified Oculus Touch controls (for Oculus/Meta/PICO devices):
    - Show/Hide Working Set - Left Menu
    - Space Drag - Right Joystick Click
    - Space Rotate - Left Joystick Click
    - Space Reset - Double Left Joystick Click
