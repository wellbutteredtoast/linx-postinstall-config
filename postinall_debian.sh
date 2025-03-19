#!/bin/bash

# This is expected to be run in sudo mode, since it 
# installs to /usr/ in some instances.

set -e

TEMP=~/POSTINSTALLTEMP

clear
echo 'Updating the System...'
sudo apt-get update -y >> /dev/null 2>&1
sudo apt-get upgrade -y >> /dev/null 2>&1

echo 'Installing development libraries...'
mkdir -p $TEMP

sudo apt-get install cmake ninja make clang++ clang git -y >> /dev/null 2>&1

echo 'Building SDL...'
git clone https://github.com/libsdl-org/SDL $TEMP/sdl2
mkdir $TEMP/sdl2/build
cd $TEMP/sdl2
cmake -S . -B build
cmake --build build --config Release
sudo cmake --install build --prefix /usr/local

echo ''
echo 'Installing ZSH...'
sudo apt-get install zsh -y >> /dev/null 2>&1

echo 'Installing Python Headers...'
sudo apt-get install python3-dev -y >> /dev/null 2>&1

echo 'Cleaning up temp...'
rm -rf "$TEMP"

clear
echo 'The operation has completed!'