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

echo "[*] Creating vpn.sh file"
cp vpn.sh /home/kali
chmod +x /home/kali/vpn.sh
chown kali:kali /home/kali/vpn.sh

echo "[*] Installing Nitrogen"
sudo apt-get install nitrogen
cp wallpaper.jpg /usr/share/wallpapers/wallpaper-main.jpg
cp wallpaper_kali.png /usr/share/wallpapers/wallpaper-kali.png
chown kali:kali /usr/share/wallpapers/* -R

echo "[*] Moving in /opt/"
cd /opt/

echo "[*] Installing Sliver C2"
curl https://sliver.sh/install|sudo bash
sudo systemctl start sliver.service

echo "[*] Installing Havoc C2"
git clone https://github.com/HavocFramework/Havoc.git
sudo apt install -y git build-essential apt-utils cmake libfontconfig1 libglu1-mesa-dev libgtest-dev libspdlog-dev libboost-all-dev libncurses5-dev libgdbm-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev mesa-common-dev qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5websockets5 libqt5websockets5-dev qtdeclarative5-dev golang-go qtbase5-dev libqt5websockets5-dev python3-dev libboost-all-dev mingw-w64 nasm
cd teamserver
go mod download golang.org/x/sys
go mod download github.com/ugorji/go
cd ..
# Install musl Compiler & Build Binary (From Havoc Root Directory)
make ts-build

# Build the client Binary (From Havoc Root Directory)
make client-build

echo "[*] Installing Mythic C2"
apt install docker.io docker-compose -y
cd /opt/
git clone https://github.com/its-a-feature/Mythic
cd Mythic
make
sleep 5
./mythic-cli install github https://github.com/MythicAgents/Apollo.git
./mythic-cli install github https://github.com/MythicC2Profiles/http
rm /opt/Mythic/InstalledServices/http/http/c2_code/config.json
cp /home/kali/Kali_Setup/mythic_http_config.json /opt/Mythic/InstalledServices/http/http/c2_code/config.json

echo "[*] Cloning useful tools"
cd /opt

git clone https://github.com/Flangvik/SharpCollection
git clone https://github.com/drk1wi/Modlishka
mkdir Ligolo-ng
cd Ligolo-ng
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.5.1/ligolo-ng_proxy_0.5.1_windows_amd64.zip
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.5.1/ligolo-ng_proxy_0.5.1_linux_amd64.tar.gz
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.5.1/ligolo-ng_agent_0.5.1_windows_amd64.zip
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.5.1/ligolo-ng_agent_0.5.1_linux_amd64.tar.gz

cd /opt
wget https://github.com/cyberisltd/NcatPortable/raw/master/ncat.exe
git clone https://github.com/ParrotSec/mimikatz
git clone https://github.com/danielmiessler/SecLists

mkdir Chisel
cd Chisel
wget https://github.com/jpillora/chisel/releases/download/v1.9.1/chisel_1.9.1_linux_amd64.gz
wget https://github.com/jpillora/chisel/releases/download/v1.9.1/chisel_1.9.1_windows_amd64.gz
cd /opt




