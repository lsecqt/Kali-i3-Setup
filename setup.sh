#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "[*] INSTALLING I3"
apt-get install i3

echo "[*] Copying i3 config"
mkdir /home/kali/.config
mkdir /home/kali/.config/i3
cp i3_config /home/kali/.config/i3/config


echo "[*] INSTALLING POLYBAR"
apt-get install polybar

echo "[*] Copying polybar config"
cp polybar_config.ini /etc/polybar/config.ini

echo "[*] Installing picom"
apt-get install picom

echo "[*] Migrating xfce4-panel"
rm /home/kali/.config/xfce4/panel/*
tar -xf panel_export.tar.bz2 --directory /home/kali/.config/xfce4/panel/

echo "[*] Installing SUBL"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

cp vpn.sh /home/kali
chmod +x /home/kali/vpn.sh
chown kali:kali /home/kali/vpn.sh


sudo apt-get install nitrogen
cp wallpaper.jpg /usr/share/wallpapers/wallpaper-main.jpg
cp wallpaper_kali.png /usr/share/wallpapers/wallpaper-kali.png
chown kali:kali /usr/share/wallpapers/* -R