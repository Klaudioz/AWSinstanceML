# spin up a g2.2xlarge with ubuntu 14.04
# before starting, scp the tarball for cudnn (cudnn-7.5-linux-x64-v5.0-rc.tgz) to /tmp

sudo add-apt-repository ppa:ubuntugis/ubuntugis-testing -y
sudo apt update

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
locale-gen "en_US.UTF-8"
sudo dpkg-reconfigure locales

# blacklist nouveau gpu driver (in favor of CUDA)
echo -e "blacklist nouveau\nblacklist lbm-nouveau\noptions nouveau modeset=0\nalias nouveau off\nalias lbm-nouveau off\n" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
sudo update-initramfs -u

# apt prerequisites
sudo apt install -y build-essential git swig default-jdk zip zlib1g-dev libbz2-dev python2.7 python2.7-dev cmake python-pip mercurial libffi-dev libssl-dev libxml2-dev libxslt1-dev libpq-dev libmysqlclient-dev libcurl4-openssl-dev libjpeg-dev libpng12-dev gfortran libblas-dev liblapack-dev libatlas-dev libquadmath0 libfreetype6-dev pkg-config libshp-dev libsqlite3-dev libgd2-xpm-dev libexpat1-dev libgeos-dev libgeos++-dev libxml2-dev libsparsehash-dev libv8-dev libicu-dev libgdal1-dev libprotobuf-dev protobuf-compiler devscripts debhelper fakeroot doxygen libboost-dev libboost-all-dev gdal-bin linux-image-extra-virtual linux-source

# cuda
cd /tmp
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.5-18_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1404_7.5-18_amd64.deb
sudo apt update
sudo apt install -y cuda
sudo apt install linux-headers-$(uname -r)
sudo reboot now