# wayvr

Lightly edited layout, theme, and configs for WayVR.

Contained here are the following:
- [conf.d](conf.d)
  - Includes my main config file, plus extras to set timezones, font, and custom skybox.
- [theme](theme)
  - Lightly edited watch layout with media controls. Some things to keep in mind:
    - Icon paths are absolute; change `/home/curin/.config/wayvr` to match where your wayvr folder is.
    - `pavtl` is used for the Volume controls.
    - `playerctl` is used for Media controls.
  - [quick-chat panel](theme/gui/quick-chat.xml)
    - A custom panel with OSC buttons that send quick-chat messages to VRChat's Chatbox. ([#388](https://github.com/wlx-team/wayvr/pull/388)).
- [sound](sound)
  - Custom sounds ([#379](https://github.com/wlx-team/wayvr/pull/379)).
- [aurorasky](aurorasky.dds)
    - A SteamVR Void background converted to DDS format, since I wanted a darker skybox and finding a different one turned out to be more effort than I could be bothered with when this one was already perfect.
- [openxr_actions](openxr_actions.json5)
    - I changed the Oculus controller profile (Oculus/Meta/PICO devices)
      - Other profiles are not included; don't replace yours with mine if you have different controllers.
    - Show/Hide Working Set - Left Menu
    - Space Drag - Left Joystick Click or Right Joystick Click.
    - Space Reset - Double Left Joystick Click.
- [pollhw](pollhw.sh)
  - A script to poll hardware stats like CPU/GPU usage and temperatures. Currently unused due to the UI refresh; I need to re-make my watch and overlays.
