#!/bin/sh

curl -o sample_weight.pkl -L https://raw.githubusercontent.com/oreilly-japan/deep-learning-from-scratch/master/ch03/sample_weight.pkl
curl -o train-images-idx3-ubyte.gz -L http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
curl -o train-labels-idx1-ubyte.gz -L http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
curl -o t10k-images-idx3-ubyte.gz -L http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
curl -o t10k-labels-idx1-ubyte.gz -L http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz
