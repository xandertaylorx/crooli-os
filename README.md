<p align="center">
  <img src="web/assets/app-icon.svg" width="96" alt="Crooli OS">
</p>

<h1 align="center">Crooli OS</h1>

<p align="center">
  A calm, fast desktop for people who don't want to think about their operating system.<br>
  Made by <a href="https://crooli.com">Crooli</a>. Free and open source.<br>
  <a href="https://os.crooli.com"><b>os.crooli.com</b></a>
</p>

---

Crooli OS is a Linux distribution for people who have never used Linux. It
should feel finished on first boot: one clean desktop, an app store, updates
that install themselves, and no terminal required for anything.

It's built on **Debian 13 (trixie)** and a stripped-back **GNOME** desktop,
styled in Crooli's visual language: Ink and Paper, Signal blue, and the
Crooli Sans typeface.

## What's inside

| | |
|---|---|
| **Installer** | Calamares with five short screens. Erase-and-install is the default; encryption is one checkbox. |
| **Desktop** | GNOME restyled as Crooli: a quiet top bar with a Crooli menu, a floating dock, dark mode by default, Crooli Sans and Papirus icons. |
| **Look** | One colour system across the shell, Files, Settings, the terminal (Ptyxis), the installer and the boot screen, in dark and light. |
| **Apps** | GNOME Software with Flathub built in, plus Firefox, Files, Calendar, Text Editor, Photos, Camera and more. |
| **Updates** | Security updates install in the background (`unattended-upgrades`). App updates download automatically. |
| **Lightweight** | Minimal GNOME, no recommended packages pulled in, compressed RAM swap (zram) instead of a swap partition. |
| **Hardware** | Non-free firmware included so Wi-Fi, graphics and sound work out of the box. UEFI, Secure Boot and BIOS. |
| **Privacy** | No telemetry, no accounts, location services off by default. |

Minimum: 2 GB RAM (4 GB recommended) and 16 GB storage. There are two downloads:

| For | File |
|---|---|
| Intel or AMD PC | `crooli-os-amd64.iso` |
| Mac with Apple silicon (in UTM, Parallels or VMware), or an ARM PC | `crooli-os-arm64.iso` |

The ARM version runs natively in a virtual machine on an M-series Mac. It does not install onto a Mac's own disk; that needs Asahi Linux.

## Repository layout

```
auto/            live-build entry points (config, build, clean)
config/
  package-lists/ every package on the ISO, grouped by purpose
  hooks/         scripts that run inside the image while it's built
  includes.chroot/ files copied as-is into the system:
    etc/calamares/      the installer and its Crooli branding
    etc/dconf/          desktop defaults (dock, fonts, wallpaper, ...)
    usr/bin/            crooli-welcome, crooli-install
    usr/share/          wallpapers, logos, Crooli Sans
web/             the Crooli OS website (static, deployed to os.crooli.com by Vercel)
vercel.json      tells Vercel to serve web/ as-is, with no build step
build.sh         one-command build
```

## Build the ISO

On any machine with Docker or Podman (macOS included):

```bash
./build.sh          # builds for this machine (ARM on an Apple silicon Mac)
./build.sh amd64    # Intel and AMD PCs
./build.sh arm64    # Apple silicon VMs and ARM PCs
```

On Debian with `live-build` installed, the same script runs it natively.
The ISO appears in the repository root, for example `crooli-os-1.1.2-arm64.hybrid.iso`.
A full build takes 20–60 minutes and needs about 15 GB of free space.

Every push to `main` also builds the ISO on GitHub Actions; download it from
the run's artifacts. Tagging a commit `v*` publishes a release.

## Try it

Write the ISO to a USB stick with [balenaEtcher](https://etcher.balena.io) or
[Fedora Media Writer](https://github.com/FedoraQt/MediaWriter), boot from it,
and click **Install Crooli OS** in the dock. Or open it in a virtual machine
(GNOME Boxes, UTM, VirtualBox) with UEFI enabled.

## Contributing

Ideas, bug reports and pull requests are welcome. See
[CONTRIBUTING.md](CONTRIBUTING.md).

## License

The build configuration and Crooli OS tools are licensed under the
[GNU GPL v3](LICENSE). Crooli Sans is licensed under the
[SIL Open Font License 1.1](web/assets/fonts/OFL.txt). The Crooli name and
logo are trademarks of Crooli; please don't use them for your own forks.
Debian and GNOME packages keep their own licenses.
