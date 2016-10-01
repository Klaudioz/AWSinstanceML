sudo modprobe nvidia  # should return no errors

# cuDNN - assumes you already have the tarball in /tmp
wget https://www.dropbox.com/s/n84iy5ac2f5ab9p/cudnn-8.0-linux-x64-v5.1.tar.gz
mv cudnn-8.0-linux-x64-v5.1.tar.gz cudnn.tar.gz
tar -xzf cudnn.tar.gz
sudo cp /tmp/cuda/lib64/* /usr/local/cuda/lib64
sudo cp /tmp/cuda/include/* /usr/local/cuda/include
rm -f cudnn.tar.gz

# virtualenv
sudo pip install --upgrade pip
sudo pip install virtualenv
virtualenv venv
source venv/bin/activate

# python prerequisites
pip install https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.8.0-cp27-none-linux_x86_64.whl
pip install gdal --global-option=build_ext --global-option="-I/usr/include/gdal/"

git clone --branch v2.6.1 https://github.com/osmcode/libosmium.git /tmp/libosmium
pip install --global-option=build_ext --global-option="-I/tmp/libosmium/include" git+https://github.com/osmcode/pyosmium@v2.6.0