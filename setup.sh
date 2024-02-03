#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "[*] INSTALLING I3"
apt-get install i3

echo "[*] Copying i3 config"
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

