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
OPENWEBRTC_GST_PLUGINS_DIR=$ROOT/openwebrtc-gst-plugins

LIBRARY_PATH="$KMS_JSONCPP_DIR/src/lib_json";

#Install dependencies
sudo apt-get install --no-install-recommends -y libsoup2.4-dev libnice-dev libsctp-dev

#Build openwebrtc-gst-plugins
./build-openwebrtc-gst-plugins.sh

#Replace GST 1.5 version to 1.0 (xenial's default)
find $KMS_ELEMENTS_DIR -name CMakeLists.txt -print0 | xargs -0 sed -i -e "s/gstreamer\([a-zA-Z0-9-]*\)1.5/gstreamer\11.0/g"

#Replace libkmselementsplugins.so to libkmselements.so (This should be commited directly to kms-elements)
find $KMS_ELEMENTS_DIR -name CMakeLists.txt -print0 | xargs -0 sed -i -e "s/\${LIBRARY_NAME}plugins/\${LIBRARY_NAME}/g"

# RENAME is needed to make plugin's name matches filename, according to
# http://gstreamer-devel.966125.n4.nabble.com/Plugin-loading-fails-with-Gstreamer-1-14-0-td4686497.html
#Add "kms" to librtpendpoint.so name
sed -i -e "s/add_library(rtpendpoint/add_library(kmsrtpendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/rtpendpoint/CMakeLists.txt
sed -i -e "s/add_dependencies(rtpendpoint/add_dependencies(kmsrtpendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/rtpendpoint/CMakeLists.txt
sed -i -e "s/set_property(TARGET rtpendpoint/set_property(TARGET kmsrtpendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/rtpendpoint/CMakeLists.txt
sed -i -e "s/target_link_libraries(rtpendpoint/target_link_libraries(kmsrtpendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/rtpendpoint/CMakeLists.txt
sed -i -e "s/TARGETS rtpendpoint/TARGETS kmsrtpendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/rtpendpoint/CMakeLists.txt

#Rename libkmswebrtcpointlib.so to libkmswebrtcpoint.so
sed -i -e "s/kmswebrtcendpointlib/kmswebrtcendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/webrtcendpoint/CMakeLists.txt
sed -i -e "s/kmswebrtcendpointlib/kmswebrtcendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/webrtcendpoint/FindKmsWebRtcEndpointLib.cmake.in
sed -i -e "s/kmswebrtcendpointlib/kmswebrtcendpoint/g" $KMS_ELEMENTS_DIR/src/server/CMakeLists.txt

#Rename librecorderendpoint.so to libkmsrecorderendpoint.so
sed -i -e "s/add_library(recorderendpoint/add_library(kmsrecorderendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/recorderendpoint/CMakeLists.txt
sed -i -e "s/set_property (TARGET recorderendpoint/set_property (TARGET kmsrecorderendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/recorderendpoint/CMakeLists.txt
sed -i -e "s/target_link_libraries(recorderendpoint/target_link_libraries(kmsrecorderendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/recorderendpoint/CMakeLists.txt
sed -i -e "s/TARGETS recorderendpoint/TARGETS kmsrecorderendpoint/g" $KMS_ELEMENTS_DIR/src/gst-plugins/recorderendpoint/CMakeLists.txt

#
sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g" $KMS_ELEMENTS_DIR/debian/control
sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g" $KMS_ELEMENTS_DIR/debian/kms-elements.install

#build kms-elements
cd $KMS_ELEMENTS_DIR

KURENTO_MODULES_DIR="$KMS_CORE_DIR/src/server/kmd";
CMAKE_MODULE_PATH="$KMS_CMAKE_UTILS_DIR;$KMS_CMAKE_UTILS_DIR/CMake;$KURENTO_MODULE_CREATOR_DIR/classes;$KMS_CORE_DIR;$KMS_CORE_DIR/CMake;$KMS_CORE_DIR/src/server;$KMS_CORE_DIR/src/gst-plugins;$KMS_CORE_DIR/src/gst-plugins/commons;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;"
CMAKE_PREFIX_PATH="$KURENTO_MODULE_CREATOR_DIR;$KMS_CORE_DIR;$KMS_CORE_DIR/src/server;$KMS_CORE_DIR/src/gst-plugins;$KMS_CORE_DIR/src/gst-plugins/commons;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_JSONRPC_DIR/src/jsoncpp";
CMAKE_INSTALL_LIBDIR="lib/x86_64-linux-gnu"
CMAKE_INSTALL_PREFIX="/usr"
PKG_CONFIG_PATH="$OPENWEBRTC_GST_PLUGINS_DIR:$KMS_JSONCPP_DIR/pkg-config/";
CMAKE_CXX_FLAGS=" -I$KMS_JSONCPP_DIR/include/ -I$OPENWEBRTC_GST_PLUGINS_DIR/gst-libs/ -L$KMS_JSONCPP_DIR/src/lib_json -L$OPENWEBRTC_GST_PLUGINS_DIR/gst-libs/gst/sctp/.libs/ -L$OPENWEBRTC_GST_PLUGINS_DIR/gst/videorepair/.libs"
CMAKE_C_FLAGS="$CMAKE_CXX_FLAGS"

#TODO: this should be commited to kms-elements
sed -i -e "s/\${gstreamer-1.0_INCLUDE_DIRS}/\${gstreamer-1.0_INCLUDE_DIRS}\n\${gstreamer-sctp-1.0_INCLUDE_DIRS}/g" $KMS_ELEMENTS_DIR/src/gst-plugins/webrtcendpoint/CMakeLists.txt

env PKG_CONFIG_PATH=$PKG_CONFIG_PATH cmake -DKURENTO_MODULES_DIR=$KURENTO_MODULES_DIR -DCMAKE_MODULE_PATH=$CMAKE_MODULE_PATH -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH -DCMAKE_INSTALL_LIBDIR=$CMAKE_INSTALL_LIBDIR -DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS" -DCMAKE_C_FLAGS="$CMAKE_C_FLAGS"

LIBRARY_PATH="$KMS_JSONCPP_DIR/src/lib_json:$OPENWEBRTC_GST_PLUGINS_DIR/gst-libs/gst/sctp/.libs/:$OPENWEBRTC_GST_PLUGINS_DIR/gst/videorepair/.libs";
env LD_LIBRARY_PATH=$LIBRARY_PATH LIBRARY_PATH=$LIBRARY_PATH make

#Tests
# GST_PLUGIN_PATH="$KMS_CORE_DIR/server:$KMS_CORE_DIR/src/gst-plugins:$KMS_ELEMENTS_DIR/src/server:$KMS_ELEMENTS_DIR/src/gst-plugins";

#run all tests
#env GST_PLUGIN_PATH=$GST_PLUGIN_PATH LD_LIBRARY_PATH=$LIBRARY_PATH LIBRARY_PATH=$LIBRARY_PATH make check

#run only rtp_endpoint test
#env GST_PLUGIN_PATH=$GST_PLUGIN_PATH LD_LIBRARY_PATH=$LIBRARY_PATH LIBRARY_PATH=$LIBRARY_PATH make test_rtp_endpoint.check

cd $ROOT
