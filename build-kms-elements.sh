#!/bin/bash
# Run build-kms-core.sh before building this module
set -xe

ROOT=`pwd`
KMS_ELEMENTS_DIR=$ROOT/kms-elements
KMS_CORE_DIR=$ROOT/kms-core
KMS_CMAKE_UTILS_DIR=$ROOT/kms-cmake-utils
KURENTO_MODULE_CREATOR_DIR=$ROOT/kurento-module-creator
KMS_JSONRPC_DIR=$ROOT/kms-jsonrpc
KMS_JSONCPP_DIR=$ROOT/jsoncpp

LIBRARY_PATH="$KMS_JSONCPP_DIR/src/lib_json";

#Install dependencies
sudo apt-get install --no-install-recommends -y libsoup2.4-dev libnice-dev

#Build openwebrtc-gst-plugins
./build-openwebrtc-gst-plugins.sh

#Build libsrtp
./build-libsrtp.sh

#build kms-elements
cd $KMS_ELEMENTS_DIR

KURENTO_MODULES_DIR="$KMS_CORE_DIR/src/server/kmd";
CMAKE_MODULE_PATH="$KMS_CMAKE_UTILS_DIR;$KMS_CMAKE_UTILS_DIR/CMake;$KURENTO_MODULE_CREATOR_DIR/classes;$KMS_CORE_DIR;$KMS_CORE_DIR/CMake;$KMS_CORE_DIR/src/server;$KMS_CORE_DIR/src/gst-plugins;$KMS_CORE_DIR/src/gst-plugins/commons;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;"
CMAKE_PREFIX_PATH="$KURENTO_MODULE_CREATOR_DIR;$KMS_CORE_DIR;$KMS_CORE_DIR/src/server;$KMS_CORE_DIR/src/gst-plugins;$KMS_CORE_DIR/src/gst-plugins/commons;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_JSONRPC_DIR/src/jsoncpp";
CMAKE_INSTALL_LIBDIR="lib/x86_64-linux-gnu"
CMAKE_INSTALL_PREFIX="/usr"

cmake -DKURENTO_MODULES_DIR=$KURENTO_MODULES_DIR -DCMAKE_MODULE_PATH=$CMAKE_MODULE_PATH -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH -DCMAKE_INSTALL_LIBDIR=$CMAKE_INSTALL_LIBDIR -DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX

LIBRARY_PATH="$KMS_JSONCPP_DIR/src/lib_json";
env LD_LIBRARY_PATH=$LIBRARY_PATH LIBRARY_PATH=$LIBRARY_PATH make

#Tests
# GST_PLUGIN_PATH="$KMS_CORE_DIR/server:$KMS_CORE_DIR/src/gst-plugins:$KMS_ELEMENTS_DIR/src/server:$KMS_ELEMENTS_DIR/src/gst-plugins";

#run all tests
#env GST_PLUGIN_PATH=$GST_PLUGIN_PATH LD_LIBRARY_PATH=$LIBRARY_PATH LIBRARY_PATH=$LIBRARY_PATH make check

#run only rtp_endpoint test
#env GST_PLUGIN_PATH=$GST_PLUGIN_PATH LD_LIBRARY_PATH=$LIBRARY_PATH LIBRARY_PATH=$LIBRARY_PATH make test_rtp_endpoint.check

cd $ROOT
