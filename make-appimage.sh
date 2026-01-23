#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q unleashedrecomp-bin | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/128x128/apps/io.github.hedge_dev.unleashedrecomp.png
export DESKTOP=/usr/share/applications/io.github.hedge_dev.unleashedrecomp.desktop
export DEPLOY_PIPEWIRE=1
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1
export PATH_MAPPING='
	/usr/share/xdg-desktop-portal:${SHARUN_DIR}/share/xdg-desktop-portal
	/usr/share/dbus-1:${SHARUN_DIR}/share/dbus-1
	/usr/lib/xdg*:${SHARUN_DIR}/bin/xdg*
'

# Deploy dependencies
quick-sharun \
	/usr/bin/UnleashedRecomp      \
	/usr/lib/xdg-*-portal*        \
	/usr/share/dbus-1             \
	/usr/share/xdg-desktop-portal

# Turn AppDir into AppImage
quick-sharun --make-appimage
