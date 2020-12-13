---
slug: windows-iso-linux-usb
---

The Windows 10 ISO contains a file named `sources/install.wim` that weights more than 4G, which is the maximum file size on FAT filesystems. So the USB disk must be partitioned using a NTFS filesystem, however BIOS doesn't supporting booting from NTFS USB partitions (for whatever reason); this can be worked around by creating the bootable drive using [WoeUSB](https://github.com/slacka/WoeUSB).

```bash
nix-shell -p woeusb --run woeusbgui
```
