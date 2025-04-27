Testing VR games with WiVRn and WlxOverlay-S.
Subfolders include scripts or configs that I use.

**Note**: `amdgpu` has been encountering page faults and subsequent GPU resets for some systems, including mine.

Might be related to `linux-firmware` and combining video encoding/decoding with high load on AMD GPUs.

As of more recently, I get `ring gfx` timeouts instead of `ring vcn_enc` timeouts, so perhaps Fedora's `linux-firmware` is up to date now.

Potentially related issues:
- [ring vcn_enc_0.0 timeout cause by linux-firmware 20241210.b00a7f7e](https://gitlab.freedesktop.org/drm/amd/-/issues/3842)
- ~[Full OS crash when using media source](https://gitlab.freedesktop.org/drm/amd/-/issues/3855)~ merged with above.
- [ring gfx_0.0.0 timeout & reset failure ](https://gitlab.freedesktop.org/drm/amd/-/issues/4133)

### Variants
- [Fedora (Envision WiVRn, XRizer, AMD)](FEDORA-WiVRn-Envision.md) (Current testing setup)
- [Fedora (Flatpak WiVRn, OpenComposite, AMD)](FEDORA-WiVRn-Flatpak.md)
- [Arch Linux (Envision WiVRn, OpenComposite, AMD)](ARCH-WiVRn-Envision.md)

### Maybe future variants
- CachyOS (Envision WivRn, XRizer, AMD) / Arch-based
  - i wanna try this one out, see if it feels better to me than Fedora or pure Arch.
- Debian (Envision WiVRn, XRizer, AMD iGPU + Nvidia)
  - might move my laptop to something like debian. if i do, i'll try running envision on its quirky nvidia optimus garbage.
