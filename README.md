Testing VR games with WiVRn and WlxOverlay-S. See [linux-gaming-compat](https://github.com/cubee-cb/linux-gaming-compat) for non-VR titles.

Subfolders include scripts or configs that I use.

# Current variants
- [Dent Fedora 43 (AMD, Envision WiVRn, XRizer)](DENT-FEDORA43-WiVRn-Envision.md) - Current main setup. Previous revisions follow:
  - [Fedora 42 (Envision WiVRn, XRizer)](DENT-FEDORA42-WiVRn-Envision.md)
  - [Fedora 41 (Flatpak WiVRn, OpenComposite)](DENT-FEDORA41-WiVRn-Flatpak.md)
- [Skittles CachyOS (NVIDIA, Flatpak WiVRn, OpenComposite)](SKITTLES-CACHYOS-WiVRn-Flatpak.md) - Laptop is playing up, so this install may not be much longer for this world.

# Old variants
These are no longer in use.
- [Dent Arch Linux (AMD, Envision WiVRn, OpenComposite)](DENT-ARCH-WiVRn-Envision.md) - A USB SSD I used as intermission when Fedora 41 was practically unusable due to crashing.
- Skittles Debian Trixie (NVIDIA, Flatpak WiVRn, OpenComposite) - This lasted like a week before I replaced it with CachyOS.

# Maybe future variants
- idk lol. happy to test things, feel free to open an issue if you want me to test anything specific.

# Notes
`amdgpu` sometimes encounters page faults and subsequent GPU resets for some systems. As of more recently, I get `ring gfx` timeouts instead of `ring vcn_enc` timeouts.

Potentially related issues:
- [ring gfx_0.0.0 timeout & reset failure](https://gitlab.freedesktop.org/drm/amd/-/issues/4133)
