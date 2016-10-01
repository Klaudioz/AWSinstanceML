#!/bin/bash -e
clear
echo "============================================"
echo "Installing Caffe "
echo "============================================"
#reference doc (bottom part); https://github.com/BVLC/caffe/wiki/Install-Caffe-on-EC2-from-scratch-(Ubuntu,-CUDA-7,-cuDNN-3)

sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev protobuf-compiler gfortran libjpeg62 libfreeimage-dev libatlas-base-dev git python-dev python-pip libgoogle-glog-dev libbz2-dev libxml2-dev libxslt-dev libffi-dev libssl-dev libgflags-dev liblmdb-dev python-yaml python-numpy

sudo apt-get install  -y pypy-dev
sudo easy_install pillow

cd ~
git clone https://github.com/BVLC/caffe.git

cd caffe
cat python/requirements.txt | xargs -L 1 sudo pip install

cp Makefile.config.example Makefile.config
echo "USE_CUDNN := 1" >> Makefile.config

make pycaffe -j4
make all -j4
make test -j4

sudo ln /dev/null /dev/raw1395
echo "export PYTHONPATH=:/home/ubuntu/mxnet/python:/home/ubuntu/caffe/python" >> ~/.bashrc
source ~/.bashrc

echo "============================================"
echo "Done. Quickly test Caffe? run;"
echo "============================================"
echo "./data/mnist/get_mnist.sh"
echo "./examples/mnist/create_mnist.sh"
echo "./examples/mnist/train_lenet.sh"
echo "============================================" 