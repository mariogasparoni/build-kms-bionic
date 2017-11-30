#!/bin/bash
set -e
ROOT=`pwd`
GST_NICE_DIR=$ROOT/libnice

#Install deps
sudo apt-get install --no-install-recommends -y nasm libnice-dev

#build gst-plugins-bad
cd $GST_NICE_DIR
./autogen.sh
make

#System-wide install
echo 'You can now make install..'
sudo make install
cd $ROOT
