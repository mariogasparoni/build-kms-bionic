#!/bin/bash


#build gst-plugins-ugly
ROOT=`pwd`
GST_PLUGINS_UGLY_DIR=$ROOT/gst-plugins-ugly
sudo apt-get install --no-install-recommends -y libx264-dev
cd $GST_PLUGINS_UGLY_DIR

./autogen.sh
make
echo 'You can now make install..'
sudo make install
cd $ROOT
