#!/bin/bash


#build gst-libav
#sudo apt-get install --no-install-recommends -y
ROOT=`pwd`
GST_LIBAV_DIR=$ROOT/gst-libav
cd $GST_LIBAV_DIR

./autogen.sh
make
echo 'You can now make install..'
sudo make install
cd $ROOT
