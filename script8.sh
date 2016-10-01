#!/bin/bash -e
clear
echo "============================================"
echo "install script for Tensorflow"
echo "============================================"
#references;
#https://www.tensorflow.org/versions/r0.7/get_started/os_setup.html#installing-from-sources
#http://ramhiser.com/2016/01/05/installing-tensorflow-on-an-aws-ec2-instance-with-gpu-support/
#only r0.6 binaries worked with CUDA 7.0, isntall from source 


echo "============================================"
echo "installing a specific bzip version to prevent some stupid bug from messing things up"
echo "============================================"

cd ~/
wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
tar -zxvf bzip2-1.0.6.tar.gz
rm bzip2-1.0.6.tar.gz
cd bzip2-1.0.6
make
cd ~/


echo "============================================"
echo "installing java"
echo "============================================"

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer


echo "============================================"
echo "installing bazel"
echo "============================================"

echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://storage.googleapis.com/bazel-apt/doc/apt-key.pub.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install -y bazel

cd ~/

echo "============================================"
echo "installing tensorflow dependencies"
echo "============================================"
sudo apt-get install -y python-numpy swig python-dev

echo "============================================"
echo "installing tensorflow itself"
echo "important configuration sequence !!!!!!!!!!!!!!!!!!!(mosly default but last option is important"
echo "enter>N>N>enter>Y>enter>enter>enter>enter>enter>3.0" 
echo "make sure to answer 3.0, so it will look like this;" 
echo "Cuda compute capabilities you want to build with.[Default is: "3.5,5.2"]: 3.0" 
echo "============================================"

git clone --recurse-submodules https://github.com/tensorflow/tensorflow
cd ~/tensorflow
./configure

bazel build -c opt --config=cuda //tensorflow/cc:tutorials_example_trainer
bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
#if it doesn't work lookinto /tmp/tensorflow_pkg directory (and modify the line below for the right version )
sudo pip install --upgrade /tmp/tensorflow_pkg/tensorflow-0.10.0-py2-none-any.whl

echo "export PYTHONPATH=$PYTHONPATH:/home/ubuntu/mxnet/python:/home/ubuntu/tensorflow" >> ~/.bashrc
echo "export CUDA_HOME=/usr/local/cuda" >> ~/.bashrc
source ~/.bashrc

echo "============================================"
echo "Done setting up tensor flow, run  examples"
echo "============================================"
echo "bazel-bin/tensorflow/cc/tutorials_example_trainer --use_gpu" 
echo "python ~/tensorflow/tensorflow/models/image/mnist/convolutional.py" 
echo "============================================"