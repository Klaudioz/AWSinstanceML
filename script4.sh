#!/bin/bash -e
clear
echo "============================================"
echo "installing Theano"
echo "============================================"

cd ~/
sudo apt-get install -y python-numpy python-scipy python-dev python-pip python-nose g++ libopenblas-dev git
sudo pip install Theano

echo "============================================"
echo "Copy and paste the python source code below into 'check_theano.py' "
echo "you can run this code on the gpu with the following command" 
echo "THEANO_FLAGS=mode=FAST_RUN,device=gpu,floatX=float32 python check_theano.py"
echo "============================================"
exit

from theano import function, config, shared, sandbox
import theano.tensor as T
import numpy
import time

vlen = 10 * 30 * 768  # 10 x #cores x # threads per core
iters = 1000

rng = numpy.random.RandomState(22)
x = shared(numpy.asarray(rng.rand(vlen), config.floatX))
f = function([], T.exp(x))
print(f.maker.fgraph.toposort())
t0 = time.time()
for i in range(iters):
    r = f()
t1 = time.time()
print("Looping %d times took %f seconds" % (iters, t1 - t0))
print("Result is %s" % (r,))
if numpy.any([isinstance(x.op, T.Elemwise) for x in f.maker.fgraph.toposort()]):
    print('Used the cpu')
else:
    print('Used the gpu')