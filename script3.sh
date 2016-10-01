#!/bin/bash -e
clear
echo "============================================"
echo "Install script v4 for MXNet on AWS & Ubuntu 14.04"
echo "Runs on Community AMI > ami-1117a87a [Ubuntu 14.04 - NVIDIA CUDA base image (g2)]  + g2.2xlarge" 
echo "============================================"
echo "ssh into your instance; ssh -i 'your_key.pem' ubuntu@[code].compute-1.amazonaws.com"
echo "Check if cuda is running; run: nvidia-smi"
echo "Check if kernel module and devices are present; run: lsmod | grep -i nvidia"
echo "if it looks okay execute this install script"
echo "============================================"

echo "============================================"
echo "Installing some requirements (including opencv libraries etc)" 
echo "============================================"

sudo apt-get update;sudo apt-get install -y build-essential git libcurl4-openssl-dev libatlas-base-dev libopencv-dev python-numpy unzip

sudo apt-get install linux-image-extra-virtual



echo "============================================"
echo "Installing CUDNN" 
echo "============================================"

wget https://s3.amazonaws.com/filelocker/public_uploads/cudnn-7.0-linux-x64-v4.0-prod.tar
tar xvf cudnn-7.0-linux-x64-v4.0-prod.tar
rm cudnn-7.0-linux-x64-v4.0-prod.tar
cd cuda
sudo cp lib64/* /usr/local/cuda/lib64/
sudo cp include/cudnn.h /usr/local/cuda/include/

cd ~/

echo "============================================"
echo "Installing mxnet" 
echo "============================================"

git clone --recursive https://github.com/dmlc/mxnet
cd mxnet; cp make/config.mk .

#configure CUDA options
echo "USE_CUDA=1" >>config.mk
echo "USE_CUDA_PATH=/usr/local/cuda" >>config.mk 
echo "USE_CUDNN=1" >>config.mk
echo "USE_BLAS=atlas" >> config.mk
echo "USE_DIST_KVSTORE = 1" >>config.mk
echo "USE_S3=1" >>config.mk

make -j8

echo "============================================"
echo "Installation completed!, adding some new paths & configuring python bindings" 
echo "============================================"

#Second path can be found with the command; sudo find / -name  "libcudnn.so"
echo "export LD_LIBRARY_PATH=/home/ubuntu/mxnet/lib:/usr/local/cuda-7.5/lib64" >> ~/.bashrc
echo "export PYTHONPATH=$PYTHONPATH:/home/ubuntu/mxnet/python" >> ~/.bashrc

source ~/.bashrc
exec bash

sudo apt-get install -y python-pip python-setuptools
cd /home/ubuntu/mxnet/python
sudo python setup.py install --user
sudo ln /dev/null /dev/raw1394
cd ~/

echo "============================================"
echo "Everything should be working now. you can run the following tests" 
echo "============================================"
echo "Open a python interpreter and type 'import mxnet'"
echo "Or test it by running the following mxnet demo; "
echo "python /home/ubuntu/mxnet/example/image-classification/train_mnist.py --network lenet --gpus 0"
echo "You can also use for example; --gpus 0,1,2,3 to use (4x GPUs) on a g2.8xlarge instance"
echo "============================================" 
echo "To monitor cuda, while code is running open another ssh instance and execute 'nvidia-smi' to check GPU emory usage etc" 
echo "============================================" 