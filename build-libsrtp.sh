#!/bin/bash
set -e
ROOT=`pwd`
LIBSRTP_DIR=$ROOT/libsrtp

#Install deps

cd $LIBSRTP_DIR
./configure
make

#System-wide install
echo 'You can now make install..'
sudo make install
cd $ROOT
