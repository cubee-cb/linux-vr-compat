Testing VR games with WiVRn and WlxOverlay-S.
Subfolders include scripts or configs that I use.

**Note**: `amdgpu` has been encountering page faults and subsequent GPU resets for some systems, including mine.

May have been related to `linux-firmware` and combining video encoding/decoding with high load on AMD GPUs. As of more recently, I get `ring gfx` timeouts instead of `ring vcn_enc` timeouts.

Potentially related issues:
- [ring vcn_enc_0.0 timeout cause by linux-firmware 20241210.b00a7f7e](https://gitlab.freedesktop.org/drm/amd/-/issues/3842)
- ~[Full OS crash when using media source](https://gitlab.freedesktop.org/drm/amd/-/issues/3855)~ merged with above.
- [ring gfx_0.0.0 timeout & reset failure ](https://gitlab.freedesktop.org/drm/amd/-/issues/4133)

### Variants
- [Fedora 43 (Dent, AMD, Envision WiVRn, XRizer)](DENT-FEDORA43-WiVRn-Envision.md) - Current main setup.

### Old variants
These are no longer in use.
- [Fedora 42 (Dent, AMD, Envision WiVRn, XRizer)](DENT-FEDORA42-WiVRn-Envision.md)
- [CachyOS (Skittles, NVIDIA, Flatpak WiVRn, OpenComposite)](SKITTLES-CACHYOS-WiVRn-Flatpak.md) - Laptop is playing up.
- [Fedora 41 (Dent, AMD, Flatpak WiVRn, OpenComposite)](DENT-FEDORA41-WiVRn-Flatpak.md)
- [Arch Linux (Dent, AMD, Envision WiVRn, OpenComposite)](DENT-ARCH-WiVRn-Envision.md) - A USB SSD I used as intermission when Fedora 41 was practically unusable due to crashing.
- Debian Trixie (Skittles, NVIDIA, Flatpak WiVRn, OpenComposite) - This lasted like a week before I replaced it with CachyOS.

### Maybe future variants
- idk lol. happy to test things, feel free to open an issue if you want me to test anything specific.
