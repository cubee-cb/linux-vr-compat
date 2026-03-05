Testing VR games on Linux. See [linux-gaming-compat](https://github.com/cubee-cb/linux-gaming-compat) for non-VR titles.

Subfolders include scripts or configs that I use. Configs are available under [dotfiles](dotfiles).

# Variants
- Dent (AMD Desktop)
  - [Fedora 43 (WiVRn Git)](DENT-FEDORA43-WiVRn-Git.md) (current) - Current main setup.
  - [Fedora 43 (WiVRn Envision)](DENT-FEDORA43-WiVRn-Envision.md)
  - [Fedora 42 (WiVRn Envision)](DENT-FEDORA42-WiVRn-Envision.md)
  - [Arch Linux (WiVRn Envision)](DENT-ARCH-WiVRn-Envision.md) - A USB SSD I used as intermission when Fedora 41 was practically unusable due to crashing.
  - [Fedora 41 (WiVRn Flatpak)](DENT-FEDORA41-WiVRn-Flatpak.md)
- Skittles (AMD + NVIDIA Optimus Laptop)
  - Linux Mint / LMDE 7 (N/A) (current) - Nothing done yet.
  - Bazzite (WiVRn AtomicXR) - I installed it and did nothing with it.
  - [CachyOS (WiVRn Flatpak)](SKITTLES-CACHYOS-WiVRn-Flatpak.md) - I got bored and figured I'd try Bazzite.
  - Debian Trixie - This lasted like a week before I replaced it with CachyOS.
- FS (AMD Integrated Desktop)
  - [Manjaro (WiVRn Flatpak)](FS-MANJARO-WiVRn-Flatpak.md) (current) - Lounge family gaming PC.

# Maybe future variants
- idk lol. happy to test things, feel free to open an issue or something if you want me to test anything specific.
- I do wanna test a Steam Frame but I don't think I'll be affording one for a while. (assuming they even ship to Australia on release)
- Sequin - I could test on my Mac Mini 2018; that'll go well...
- Daisy - We also have a mini pc sitting around; probably would be similar to FS though.

# Resources
- [The Linux VR Adventures Wiki](https://lvra.gitlab.io/) - Source of information for running VR on Linux in general.
- [ProtonDB](https://www.protondb.com/) - Database of Windows Games and how well they run under Proton.
- [LVRA DB](https://db.vronlinux.org/) - Like ProtonDB, but for XR Runtimes and VR Games.

# Notes
`amdgpu` sometimes encounters page faults and subsequent GPU resets for some systems. As of more recently, I get `ring gfx` timeouts instead of `ring vcn_enc` timeouts.

Potentially related issues:
- [ring gfx_0.0.0 timeout & reset failure](https://gitlab.freedesktop.org/drm/amd/-/issues/4133)
