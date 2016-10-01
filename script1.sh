#!/bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential cmake git unzip pkg-config
sudo apt-get install -y libopenblas-dev liblapack-dev
sudo apt-get install -y linux-image-generic linux-image-extra-virtual
sudo apt-get install -y linux-source linux-headers-generic

sudo cat > /etc/modprobe.d/blacklist-nouveau.conf << EOF1
blacklist nouveau
blacklist lbm-nouveau
options nouveau modeset=0
alias nouveau off
alias lbm-nouveau off
EOF1

sudo echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
sudo update-initramfs -u
sudo reboot