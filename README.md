Testing VR games on Linux. See [linux-gaming-compat](https://github.com/cubee-cb/linux-gaming-compat) for non-VR titles.

Subfolders include scripts or configs that I use. Configs are available under [dotfiles](dotfiles).

# Variants
- Dent (AMD Desktop)
  - [Fedora 43](DENT-FEDORA43-WiVRn-Envision.md) - Current main setup.
  - [Fedora 42](DENT-FEDORA42-WiVRn-Envision.md)
  - [Fedora 41](DENT-FEDORA41-WiVRn-Flatpak.md)
  - [Arch Linux](DENT-ARCH-WiVRn-Envision.md) - A USB SSD I used as intermission when Fedora 41 was practically unusable due to crashing.
- Skittles (NVIDIA Optimus Laptop)
  - [Bazzite](SKITTLES-BAZZITE-WiVRn-AtomicXR.md) - Nothing done yet.
  - [CachyOS](SKITTLES-CACHYOS-WiVRn-Flatpak.md) - I got bored and figured I'd try Bazzite.
  - Debian Trixie - This lasted like a week before I replaced it with CachyOS.
- FS (AMD Integrated Desktop)
  - [Manjaro](FS-MANJARO-WiVRn-Flatpak.md) - Lounge family gaming PC.

# Maybe future variants
- idk lol. happy to test things, feel free to open an issue or something if you want me to test anything specific.
- I do wanna test a Steam Frame but I don't think I'll be affording one for a while. (assuming they even ship to Australia on release)
- Sequin - I could test on my Mac Mini 2018; that'll go well...
- Daisy - We also have a mini pc sitting around; probably would be similar to FS though.

# Notes
`amdgpu` sometimes encounters page faults and subsequent GPU resets for some systems. As of more recently, I get `ring gfx` timeouts instead of `ring vcn_enc` timeouts.

Potentially related issues:
- [ring gfx_0.0.0 timeout & reset failure](https://gitlab.freedesktop.org/drm/amd/-/issues/4133)
