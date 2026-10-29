#!/bin/sh
# Build the Crooli OS ISO.
#
# On Debian (or a Debian container) this runs live-build directly. Anywhere
# else (macOS, Fedora, Windows with WSL...) it runs the same build inside a
# privileged Debian container using Docker or Podman.
#
#   ./build.sh                build for this machine (arm64 on an Apple silicon Mac)
#   ./build.sh amd64          build for Intel and AMD PCs
#   ./build.sh arm64          build for Apple silicon VMs and ARM PCs
#   ./build.sh clean          remove build output
set -e

cd "$(dirname "$0")"

if [ "$1" = "clean" ]; then
	if command -v lb >/dev/null 2>&1; then
		sudo lb clean --purge
	fi
	rm -rf .build cache chroot binary local ./*.iso ./*.contents ./*.files ./*.packages ./*.log
	exit 0
fi

# Which architecture to build. Defaults to the machine we are on.
if [ -n "$1" ]; then
	ARCH="$1"
else
	case "$(uname -m)" in
		x86_64|amd64) ARCH=amd64 ;;
		aarch64|arm64) ARCH=arm64 ;;
		*) echo "Unsupported machine: $(uname -m)" >&2; exit 1 ;;
	esac
fi
case "$ARCH" in
	amd64) HOST_PACKAGES="grub-efi-amd64-bin grub-pc-bin syslinux syslinux-common isolinux" ;;
	arm64) HOST_PACKAGES="grub-efi-arm64-bin" ;;
	*) echo "Architecture must be amd64 or arm64." >&2; exit 1 ;;
esac

if [ -f /etc/debian_version ] && command -v lb >/dev/null 2>&1 && [ "$ARCH" = "$(dpkg --print-architecture)" ]; then
	sudo lb clean
	CROOLI_ARCH="$ARCH" lb config
	sudo lb build
	ls -lh ./*.iso
	exit 0
fi

ENGINE=$(command -v docker || command -v podman || true)
if [ -z "$ENGINE" ]; then
	echo "Install Docker or Podman, or run this on Debian with live-build." >&2
	exit 1
fi

# Building for the other architecture works, but is much slower (emulated).
exec "$ENGINE" run --rm --privileged \
	--platform "linux/$ARCH" \
	-e CROOLI_ARCH="$ARCH" \
	-v "$PWD":/src -w /src \
	debian:trixie sh -c "
		set -e
		apt-get update
		apt-get install -y --no-install-recommends \
			apt-utils live-build debootstrap squashfs-tools xorriso \
			mtools dosfstools ca-certificates $HOST_PACKAGES
		lb clean
		lb config
		lb build
		ls -lh ./*.iso
	"
