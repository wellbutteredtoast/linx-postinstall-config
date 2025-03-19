#!/bin/bash
set -e

TEMP=~/POSTINSTALLTEMP

echo 'Updating the System...'
sudo zypper refresh > /dev/null 2>&1
sudo zypper update -y > /dev/null 2>&1

echo 'Installing development libraries...'
mkdir -p "$TEMP"
sudo zypper install -y cmake ninja make clang gcc-c++ git zsh python3-devel > /dev/null 2>&1

echo 'Building SDL...'
git clone --depth=1 https://github.com/libsdl-org/SDL "$TEMP/sdl2"
cd "$TEMP/sdl2"
cmake -S . -B build
cmake --build build --config Release
sudo cmake --install build --prefix /usr/local

echo 'Cleaning up...'
rm -rf "$TEMP"

echo 'Post-installation complete!'
