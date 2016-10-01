#!/bin/bash -e
clear
echo "============================================"
echo "installing Torch ( enter NO at the end, this scripts handles setting up your bashrc)"
echo "============================================"
#refrences; http://torch.ch
#refrences; https://github.com/karpathy/char-rnn

cd ~/

git clone https://github.com/torch/distro.git ~/torch --recursive
cd ~/torch; bash install-deps;
./install.sh  

echo "export LD_LIBRARY_PATH=/home/ubuntu/mxnet/lib:/usr/local/cuda-7.5/lib64:/home/ubuntu/torch/install/bin/torch-activate" >> ~/.bashrc
source ~/.bashrc


echo "============================================"
echo "configuring Torch demo"
echo "Andrej Karpathy's code from The Unreasonable Effectiveness of Recurrent Neural Networks available at https://github.com/karpathy/char-rnn"
echo "http://karpathy.github.io/2015/05/21/rnn-effectiveness/" 
echo "============================================"

cd ~/
luarocks install nngraph
luarocks install optim
luarocks install nn
luarocks install cutorch
luarocks install cunn

git clone https://github.com/karpathy/char-rnn
cd char-rnn

echo "============================================"
echo "Done with setting up the example" 
echo "============================================"
echo "here is how to execute 6330 batches of training"
echo "th train.lua -gpuid -0"
echo "============================================"
echo "automatically  saves checkpoints like for example; "
echo "1000/21150 |  saving checkpoint to cv/lm_lstm_epoch2.36_1.7848.t7"
echo "============================================"
echo "Based on a earlier certain checkpoint file we can now generate new text"  
echo "th sample.lua cv/lm_lstm_epoch2.36_1.7848.t7" 
echo "============================================"