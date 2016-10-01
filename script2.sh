wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run
chmod +x cuda_7.5.18_linux.run
mkdir installers
sudo ./cuda_7.5.18_linux.run -extract=`pwd`/installers
cd installers
sudo ./NVIDIA-Linux-x86_64-352.39.run
modprobe nvidia
sudo ./cuda-linux64-rel-7.5.18-19867135.run
sudo ./cuda-samples-linux-7.5.18-19867135.run
cd ..
rm -rf installers
rm -rf cuda_7.5.18_linux.run

echo "export CUDA_HOME=/usr/local/cuda-7.5" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export PATH=${CUDA_HOME}/bin:${PATH}" >> ~/.bashrc

source ~/.bashrc
sudo reboot