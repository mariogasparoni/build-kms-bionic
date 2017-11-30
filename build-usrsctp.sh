#!/bin/bash

ROOT=`pwd`
USRSCTP_DIR=$ROOT/usrsctp

cd $USRSCTP_DIR

./bootstrap
./configure
make
#echo 'You can now make install..'
sudo make install
cd $ROOT
