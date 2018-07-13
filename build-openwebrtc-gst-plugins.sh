#!/bin/bash

set -xe

#build gst-plugins-base
ROOT=`pwd`
OPENWEBRTC_GST_PLUGINS_DIR=$ROOT/openwebrtc-gst-plugins
INSTALL_PREFIX="/usr"
LIBDIR="/usr/lib/x86_64-linux-gnu/"
USRSCTP_DIR=$ROOT/usrsctp
CFLAGS=" -I$USRSCTP_DIR/usrsctplib -L$USRSCTP_DIR/usrsctplib/.libs"
./build-usrsctp.sh

#Replace GST 1.5 version to 1.0 (xenial's default)
find $OPENWEBRTC_GST_PLUGINS_DIR -name *.ac -print0 | xargs -0 sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g"
find $OPENWEBRTC_GST_PLUGINS_DIR -name *.am -print0 | xargs -0 sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g"
find $OPENWEBRTC_GST_PLUGINS_DIR -name *.install -print0 | xargs -0 sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g"
find $OPENWEBRTC_GST_PLUGINS_DIR -name *.in -print0 | xargs -0 sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g"
sed -i -e "s/GST_REQUIRED=1.5/GST_REQUIRED=1.0/g" $OPENWEBRTC_GST_PLUGINS_DIR/configure.ac
sed -i -e "s/GSTPB_REQUIRED=1.5/GSTPB_REQUIRED=1.0/g" $OPENWEBRTC_GST_PLUGINS_DIR/configure.ac
sed -i -e "s/libgstsctp_1_5/libgstsctp_1_0/g" $OPENWEBRTC_GST_PLUGINS_DIR/gst-libs/gst/sctp/Makefile.am
sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g" $OPENWEBRTC_GST_PLUGINS_DIR/debian/control

if [ -f $OPENWEBRTC_GST_PLUGINS_DIR/gstreamer-sctp-1.5.pc.in ]
then
  mv $OPENWEBRTC_GST_PLUGINS_DIR/gstreamer-sctp-1.5.pc.in $OPENWEBRTC_GST_PLUGINS_DIR/gstreamer-sctp-1.0.pc.in
fi

if [ -f $OPENWEBRTC_GST_PLUGINS_DIR/gstreamer-sctp-1.5-uninstalled.pc.in ]
then
  mv $OPENWEBRTC_GST_PLUGINS_DIR/gstreamer-sctp-1.5-uninstalled.pc.in $OPENWEBRTC_GST_PLUGINS_DIR/gstreamer-sctp-1.0-uninstalled.pc.in
fi
cd $OPENWEBRTC_GST_PLUGINS_DIR

./autogen.sh
env CFLAGS="$CFLAGS" ./configure --prefix=$INSTALL_PREFIX --libdir=$LIBDIR

#This file mess with GenericFind/pkg_check_modules when looking for gstreamer-sctp-1.0.pc: remove it
rm $OPENWEBRTC_GST_PLUGINS_DIR/gstreamer-sctp-1.0-uninstalled.pc

make
cd $ROOT
