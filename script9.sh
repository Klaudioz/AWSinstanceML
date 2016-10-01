#!/bin/bash -e
clear
echo "============================================"
echo "first verify all the above script examples etc work individually" 
echo "To have all examples etc work next to eachother, clean up your ~/.bashrc"
echo "open up your ~/.bashrc and put a # before lines starting with PYTHONPATH, LD_LIBRARY_PATH, CUDA_HOME"
echo "then run the script below" 
echo "============================================"

echo "export PYTHONPATH=$PYTHONPATH:/home/ubuntu/mxnet/python:/home/ubuntu/tensorflow:/home/ubuntu/caffe/python" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/home/ubuntu/mxnet/lib:/usr/local/cuda-7.5/lib64:/home/ubuntu/torch/install/bin/torch-activate" >> ~/.bashrc
echo "export CUDA_HOME=/usr/local/cuda" >> ~/.bashrc 
source ~/.bashrc