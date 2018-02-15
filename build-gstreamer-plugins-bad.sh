#!/bin/bash
set -e
ROOT=`pwd`
GST_PLUGINS_BAD_DIR=$ROOT/gst-plugins-bad

#Install deps
sudo apt-get install --no-install-recommends -y nasm libegl1-mesa-dev libgl1-mesa-dev libgles2-mesa-dev libglu1-mesa-dev libsrtp-dev libpcap-dev

#Install openh264 lib

OPENH264_VERSION=1.4.0

if [ ! -d /usr/local/src/openh264-${OPENH264_VERSION} ]; then
        echo "Download and unpacking openh264..."
        cd /usr/local/src
        sudo wget https://github.com/cisco/openh264/archive/v${OPENH264_VERSION}.tar.gz
        sudo tar -xvf v${OPENH264_VERSION}.tar.gz
        cd /usr/local/src/openh264-${OPENH264_VERSION}
        echo "Compiling openh264"
        sudo make
        echo "Installing openh264"
        sudo make install
        echo "Making symbolic link"
        #check ldd ("ldd ffmpeg") if couldn't find libopenh264.so when running ffmpeg
        sudo ln -s -f /usr/local/lib/libopenh264.so.0 /usr/lib/x86_64-linux-gnu/
else
  echo "libopenh264: ${OPENH264_VERSION} already installed"
fi

#build gst-plugins-bad
cd $GST_PLUGINS_BAD_DIR
./autogen.sh --enable-compositor --enable-gtk-doc=no
make

#System-wide install
echo 'You can now make install..'
sudo make install
cd $ROOT
