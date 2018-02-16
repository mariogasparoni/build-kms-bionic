#!/bin/bash


#gstreamer deps
sudo apt-get update && sudo apt-get install --no-install-recommends -y automake autoconf autopoint bison flex gtk-doc-tools libglib2.0-dev

#clone repos
./clone-gstreamer-and-plugins.sh

#Build kurento's gstreamer
ROOT=`pwd`
GSTREAMER_DIR=$ROOT/gstreamer
cd $GSTREAMER_DIR

./autogen.sh
make
echo 'You can now make install..'
#Gstreamer we do a system-wide install
sudo make install
cd $ROOT

#Install plugins
#build gst-plugins-base
./build-gstreamer-plugins-base.sh

#build gst-plugins-bad
./build-gstreamer-plugins-bad.sh

#build gst-plugins-good
./build-gstreamer-plugins-good.sh

#build gst-plugins-ugly
./build-gstreamer-plugins-ugly.sh

#build gst-libav
./build-gstreamer-libav.sh
