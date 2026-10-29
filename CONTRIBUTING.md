# Contributing to Crooli OS

Thanks for helping. Crooli OS has one rule that decides most questions:

> **Would someone who has never used Linux understand this without help?**

If a change adds a setting, a prompt, or a step, it needs a good reason.
If it removes one, it's probably welcome.

## Where things live

- **Add or remove an app or driver:** `config/package-lists/`
- **Change a desktop default** (dock, fonts, wallpaper, behaviour):
  `config/includes.chroot/etc/dconf/db/crooli.d/00-crooli`
- **Change the installer:** `config/includes.chroot/etc/calamares/`
- **Change the Welcome app:** `config/includes.chroot/usr/bin/crooli-welcome`
- **Anything that must run inside the image at build time:** `config/hooks/normal/`
- **The website:** `web/`

## Testing a change

1. Build the ISO with `./build.sh` (or push a branch and download the ISO
   from the GitHub Actions run).
2. Boot it in a VM with UEFI enabled. Check the live session, then install
   it and check the installed system too.
3. Describe what you tested in the pull request.

## Brand

Crooli OS follows the [Crooli brand guidelines](https://crooli.com/brand):
use the supplied logo artwork unchanged, keep colour to small signals, and
set text in Crooli Sans.
