sudo apt-add-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install libgdal-dev python-dev libboost-python-dev libbz2-dev

# cuDNN
wget https://www.dropbox.com/s/n84iy5ac2f5ab9p/cudnn-8.0-linux-x64-v5.1.tar.gz
mv cudnn-8.0-linux-x64-v5.1.tar.gz cudnn.tar.gz
tar -xzf cudnn.tar.gz
sudo cp ~/cuda/lib64/* /usr/local/cuda/lib64
sudo cp ~/cuda/include/* /usr/local/cuda/include
rm -f cudnn.tar.gz

# virtualenv
sudo apt-get install -y python-pip python-setuptools
sudo pip install --upgrade pip
sudo pip install virtualenv
virtualenv venv
source venv/bin/activate

# python prerequisites
pip install https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.8.0-cp27-none-linux_x86_64.whl
pip install gdal --global-option=build_ext --global-option="-I/usr/include/gdal/"

git clone --branch v2.6.1 https://github.com/osmcode/libosmium.git /tmp/libosmium
pip install --global-option=build_ext --global-option="-I/tmp/libosmium/include" git+https://github.com/osmcode/pyosmium@v2.6.0

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64"
export CUDA_HOME=/usr/local/cuda
source venv/bin/activate
