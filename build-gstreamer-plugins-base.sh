#!/bin/bash


#build gst-plugins-base
sudo apt-get install --no-install-recommends -y libasound2-dev libopus-dev libcdparanoia0-dev libogg-dev libvorbis-dev libvorbisidec-dev libtheora-dev libvisual-0.4-dev liborc-0.4-dev  libpango1.0-dev libxv-dev
ROOT=`pwd`
GST_PLUGINS_BASE_DIR=$ROOT/gst-plugins-base
cd $GST_PLUGINS_BASE_DIR

./autogen.sh
make
echo 'You can now make install..'
sudo make install
cd $ROOT
