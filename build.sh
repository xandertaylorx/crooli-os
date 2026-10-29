#!/bin/sh
# Build the Crooli OS ISO.
#
# On Debian (or a Debian container) this runs live-build directly. Anywhere
# else (macOS, Fedora, Windows with WSL...) it runs the same build inside a
# privileged Debian container using Docker or Podman.
#
#   ./build.sh          build the ISO
#   ./build.sh clean    remove build output
set -e

cd "$(dirname "$0")"

if [ "$1" = "clean" ]; then
	if command -v lb >/dev/null 2>&1; then
		sudo lb clean --purge
	fi
	rm -rf .build cache chroot binary local *.iso *.contents *.files *.packages *.log
	exit 0
fi

if [ -f /etc/debian_version ] && command -v lb >/dev/null 2>&1; then
	sudo lb clean
	lb config
	sudo lb build
	ls -lh ./*.iso
	exit 0
fi

ENGINE=$(command -v docker || command -v podman || true)
if [ -z "$ENGINE" ]; then
	echo "Install Docker or Podman, or run this on Debian with live-build." >&2
	exit 1
fi

exec "$ENGINE" run --rm --privileged \
	--platform linux/amd64 \
	-v "$PWD":/src -w /src \
	debian:trixie sh -c '
		set -e
		apt-get update
		apt-get install -y --no-install-recommends \
			apt-utils live-build debootstrap squashfs-tools xorriso \
			grub-efi-amd64-bin grub-pc-bin mtools dosfstools \
			syslinux syslinux-common isolinux ca-certificates
		lb clean
		lb config
		lb build
		ls -lh ./*.iso
	'
