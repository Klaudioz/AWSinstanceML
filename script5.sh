#!/bin/bash -e
clear
echo "============================================"
echo "Installing dlib" 
echo "============================================"
#reference http://npatta01.github.io/2015/08/10/dlib/
cd ~/
git clone https://github.com/davisking/dlib.git
cd dlib
sudo python setup.py install --yes DLIB_JPEG_SUPPORT
echo "============================================"
echo "To test dlib run" 
echo "python ~/dlib/python_examples/svm_rank.py" 
echo "============================================"