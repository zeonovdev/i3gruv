#!/bin/bash
set -e

if [ "$EUID" == 0 ]; then
  echo "Please do not run as root"
  exit
fi

echo "Downloads packages..."
sudo apt update 
sudo apt upgrade
sudo apt install rofi picom i3 polybar nitrogen nwg-look curl wget dunst brightnessctl maim slop xclip bc kitty fastfetch imagemagick

echo "Cloning wallpapers..."
if [ ! -d "$HOME/Pictures" ]; then
	mkdir $HOME/Pictures
fi

if [ ! -d "$HOME/Pictures/wallpapers" ]; then
	mkdir $HOME/Pictures/wallpapers
fi
cp wallpapers/wallpaper2.jpg $HOME/Pictures/wallpapers
echo "Please change wallpaper after install config."

echo "Installing i3lock-color and betterlockscreen..."
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev libgif-dev

git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
betterlockscreen -u $HOME/Pictures/wallpapers/wallpaper2.jpg

echo "Coping config files..."
cp -r i3 $HOME/.config
cp -r kitty $HOME/.config
cp -r fastfetch $HOME/.config
cp -r polybar $HOME/.config
cp -r rofi $HOME/.config
cp -r picom $HOME/.config 

echo "Installing power/wifi menu..."
sudo cp -r rofi-power-menu /bin/                     
sudo cp -r rofi-wifi-menu.sh /bin/

echo "Installing font..."
sudo cp -r Fonts/* /usr/share/fonts

echo "Installing theme and icons..."
sudo cp -r icons/* /usr/share/icons
sudo cp -r themes/* /usr/share/themes

echo "Config installation complete."
                  


