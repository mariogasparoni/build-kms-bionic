#!/bin/bash


#build gst-plugins-base
ROOT=`pwd`
OPENWEBRTC_GST_PLUGINS_DIR=$ROOT/openwebrtc-gst-plugins

./build-gstreamer-nice.sh
./build-usrsctp.sh
cd $OPENWEBRTC_GST_PLUGINS_DIR

./autogen.sh
./configure
make
#echo 'You can now make install..'
sudo make install
cd $ROOT
