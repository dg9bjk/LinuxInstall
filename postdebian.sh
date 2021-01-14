#!/bin/sh
#
cd /etc/apt
sed 's/main/main contrib non-free/g' -i sources.list
cd /
#
apt-get check
apt-get update
apt-get upgrade
apt-get dist-upgrade
#
apt-get -y install joe
apt-get -y install mc
apt-get -y install psmisc
apt-get -y install tcpdump
apt-get -y install gcc
apt-get -y install g++
apt-get -y install gdb
apt-get -y install strace
apt-get -y install wireshark
apt-get -y install make
apt-get -y install automake
apt-get -y install cmake
apt-get -y install linux-headers-$(uname -r)
apt-get -y install ffmpeg
apt-get -y install ssh
apt-get -y install ftp
apt-get -y install ncftp
apt-get -y install filezilla
apt-get -y install nmap
apt-get -y install git
apt-get -y install unrar
apt-get -y install libreoffice
apt-get -y install vlc
apt-get -y install firefox-esr
apt-get -y install thunderbird
apt-get -y install audacity
apt-get -y install net-tools
#
