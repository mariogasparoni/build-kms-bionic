#!/bin/bash


#build gst-plugins-good
sudo apt-get install --no-install-recommends -y libspeex-dev
ROOT=`pwd`
GST_PLUGINS_GOOD_DIR=$ROOT/gst-plugins-good
cd $GST_PLUGINS_GOOD_DIR

./autogen.sh
make
echo 'You can now make install..'
sudo make install
cd $ROOT
