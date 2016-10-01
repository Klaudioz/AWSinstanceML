#!/bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential cmake git unzip pkg-config
sudo apt-get install -y libopenblas-dev liblapack-dev
sudo apt-get install -y linux-image-generic linux-image-extra-virtual
sudo apt-get install -y linux-source linux-headers-generic

sudo touch /etc/modprobe.d/blacklist-nouveau.conf
sudo echo "blacklist nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
sudo echo "blacklist lbm-nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
sudo echo "options nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf
sudo echo "alias nouveau off" >> /etc/modprobe.d/blacklist-nouveau.conf
sudo echo "alias lbm-nouveau off" >> /etc/modprobe.d/blacklist-nouveau.conf

sudo echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
sudo update-initramfs -u
sudo reboot