Testing VR games on Linux. See [linux-gaming-compat](https://github.com/cubee-cb/linux-gaming-compat) for non-VR titles.

Subfolders include scripts or configs that I use.

# Current variants
- Dent (Fedora, AMD)
  - [Fedora 43](DENT-FEDORA43-WiVRn-Envision.md) - Current main setup.
  - [Fedora 42](DENT-FEDORA42-WiVRn-Envision.md)
  - [Fedora 41](DENT-FEDORA41-WiVRn-Flatpak.md)
- Skittles (Arch, NVIDIA)
  - [CachyOS](SKITTLES-CACHYOS-WiVRn-Flatpak.md) - Laptop is playing up, so this install may not be much longer for this world.

# Old variants
These are no longer in use.
- Dent (Arch, AMD)
  - [Arch Linux](DENT-ARCH-WiVRn-Envision.md) - A USB SSD I used as intermission when Fedora 41 was practically unusable due to crashing.
- Skittles (Debian, NVIDIA)
  - Debian Trixie - This lasted like a week before I replaced it with CachyOS.

# Maybe future variants
- idk lol. happy to test things, feel free to open an issue or something if you want me to test anything specific.

i want a steam frame so much

pls gaben let it be affordable and not over 1.5 grand AUD like the index was. free me from the shackles of android and spyware.
- hm, i guess this means we'll get steamvr working properly on linux then, right?

pros:

- open system on linux; hackable
- can run pcvr things natively and also android stuff cause why not
- get eye tracking for no effort
- no more meta and pico spyware
- expandable/swappable storage and battery
  - quest is a pain to get into for battery replacement, and pico 4 has a non-modular headstrap
- wlxoverlay-s should still work via steamvr

cons:

- lose access to FBT (PICO motion trackers)
  - easily solvable with slimes or potentially fluxpose, but more money
- maybe cannot use wivrn anymore; relying on valve to make steamvr on linux actually work again
  - i wonder; would wivrn work out of the box via Lepton? it's an OpenXR app after all
  - i'm sure someone will port it over anyway just for compatibility, freedom of choice, etc. i for one wanna keep using wivrn

# Notes
`amdgpu` sometimes encounters page faults and subsequent GPU resets for some systems. As of more recently, I get `ring gfx` timeouts instead of `ring vcn_enc` timeouts.

Potentially related issues:
- [ring gfx_0.0.0 timeout & reset failure](https://gitlab.freedesktop.org/drm/amd/-/issues/4133)
