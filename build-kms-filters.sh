#!/bin/bash
set -xe

ROOT=`pwd`
KMS_FILTERS_DIR=$ROOT/kms-filters
KMS_CORE_DIR=$ROOT/kms-core
KMS_ELEMENTS_DIR=$ROOT/kms-elements
KMS_CMAKE_UTILS_DIR=$ROOT/kms-cmake-utils
KURENTO_MODULE_CREATOR_DIR=$ROOT/kurento-module-creator
KMS_JSONRPC_DIR=$ROOT/kms-jsonrpc
KMS_JSONCPP_DIR=$ROOT/jsoncpp
#Run build-kms-core.sh if the above modules aren't built

LIBRARY_PATH="$KMS_JSONCPP_DIR/src/lib_json";

#Install dependencies
sudo apt-get install --no-install-recommends -y libopencv-dev

#Uncoment 'builds' scripts if this is the first time building
#Build kms-elements
#./build-kms-elements.sh

#Replace GST 1.5 version to 1.0 (xenial's default)
find $KMS_FILTERS_DIR -name CMakeLists.txt -print0 | xargs -0 sed -i -e "s/gstreamer\([a-zA-Z0-9-]*\)1.5/gstreamer\11.0/g"

sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g" $KMS_FILTERS_DIR/debian/control
sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g" $KMS_FILTERS_DIR/debian/kms-filters.install

#build kms-filters
cd $KMS_FILTERS_DIR
KURENTO_MODULES_DIR="$KMS_CORE_DIR/src/server/kmd;$KMS_ELEMENTS_DIR/src/server/kmd";
CMAKE_MODULE_PATH="$KMS_CMAKE_UTILS_DIR;$KMS_CMAKE_UTILS_DIR/CMake;$KURENTO_MODULE_CREATOR_DIR/classes;$KMS_CORE_DIR;$KMS_CORE_DIR/CMake;$KMS_CORE_DIR/src/server;$KMS_CORE_DIR/src/gst-plugins;$KMS_CORE_DIR/src/gst-plugins/commons;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_ELEMENTS_DIR/src/server"
CMAKE_PREFIX_PATH="$KURENTO_MODULE_CREATOR_DIR;$KMS_CORE_DIR;$KMS_CORE_DIR/src/server;$KMS_CORE_DIR/src/gst-plugins;$KMS_CORE_DIR/src/gst-plugins/commons;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_JSONRPC_DIR/src/jsoncpp;$KMS_ELEMENTS_DIR";

cmake -DKURENTO_MODULES_DIR=$KURENTO_MODULES_DIR -DCMAKE_MODULE_PATH=$CMAKE_MODULE_PATH -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH .
env LIBRARY_PATH=$LIBRARY_PATH make
cd $ROOT
