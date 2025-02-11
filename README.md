Testing VR games with WiVRn and WlxOverlay-S.
Subfolders include scripts or configs that I use.

**Note**: Recently `amdgpu` was encountering page faults and subsequent GPU resets for some systems, including mine.

It looks to be related to `linux-firmware` and video encoding/decoding on AMD GPUs, and the broken version has been reverted. Fedora seems to still have this issue as they have not updated `linux-firmware` yet?

Tracked here:
- [ring vcn_enc_0.0 timeout cause by linux-firmware 20241210.b00a7f7e](https://gitlab.freedesktop.org/drm/amd/-/issues/3842)
- ~[Full OS crash when using media source](https://gitlab.freedesktop.org/drm/amd/-/issues/3855)~ merged with above.

### Variants
- [Fedora](FEDORA.md)
- [Arch Linux](ARCH.md)
