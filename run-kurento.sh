#!/bin/bash

set -x
ROOT=`pwd`
KURENTO_MEDIA_SERVER_DIR=$ROOT/kurento-media-server

DEBUG_LEVEL=4;
DEBUG_LEVEL=2,*treebin*:6,*elementfactory*:6,*endpoint*:6,*agnostic*:6;
KMS_CORE_DIR=$ROOT/kms-core
KMS_FILTERS_DIR=$ROOT/kms-filters
KMS_ELEMENTS_DIR=$ROOT/kms-elements
KMS_JSONRPC_DIR=$ROOT/kms-jsonrpc
KMS_JSONCPP_DIR=$ROOT/jsoncpp
KMS_CONFIG_FILE=$KURENTO_MEDIA_SERVER_DIR/kurento.conf.json
OPENWEBRTC_GST_PLUGINS_DIR=$ROOT/openwebrtc-gst-plugins

#Kurento find modules recursively, so we don't need to add subfolders

#needed modules:
# libkmscoremodule.so
# libkmselementsmodule.so
# libkmsfiltersmodule.so
#
# GST PLUGINS:
GST_PLUGIN_PATH="$KMS_CORE_DIR/server:$KMS_CORE_DIR/src/gst-plugins:$KMS_ELEMENTS_DIR/src/server:$KMS_ELEMENTS_DIR/src/gst-plugins:$KMS_FILTERS_DIR/src/server:$KMS_FILTERS_DIR/src/gst-plugins";
# You can test if KMS plugins are loaded correctly by using gst-inspect:
#env GST_PLUGIN_PATH=$GST_PLUGIN_PATH gst-inspect-1.5 | grep kms

#Path where to load libkmscoremodule.so, libkmselementsmodule.so and libkmsfiltersmodule.so
MODULES_DIR="$KMS_CORE_DIR/src/server:$KMS_FILTERS_DIR/src/server:$KMS_ELEMENTS_DIR/src/server";
MODULES_CONFIG_DIR="$KMS_CORE_DIR/modules_config:$KMS_ELEMENTS_DIR/modules_config";

#System libs
LIBRARY_PATH="/usr/local/lib:$KMS_JSONCPP_DIR/src/lib_json:$KMS_JSONRPC_DIR/src:$OPENWEBRTC_GST_PLUGINS_DIR/gst-libs/gst/sctp/.libs/:$OPENWEBRTC_GST_PLUGINS_DIR/gst/videorepair/.libs";

cd $KURENTO_MEDIA_SERVER_DIR/server
env LD_LIBRARY_PATH=$LIBRARY_PATH GST_PLUGIN_PATH=$GST_PLUGIN_PATH GST_DEBUG=$DEBUG_LEVEL ./kurento-media-server -f $KMS_CONFIG_FILE -p $MODULES_DIR -c $MODULES_CONFIG_DIR
