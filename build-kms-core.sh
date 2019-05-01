#!/bin/bash

set -xe

ROOT=`pwd`
KMS_CORE_DIR=$ROOT/kms-core

#Install dependencies
./install-base-dependencies.sh

#Build kms-cmake-utils
#Make sure kms-cmake-utils and kms-core are in the same path
KMS_CMAKE_UTILS_DIR=$ROOT/kms-cmake-utils
./build-kms-cmake-utils.sh

#Build kurento-module-creator
#Make sure kurento-module-creator and kms-core are in the same path
KURENTO_MODULE_CREATOR_DIR=$ROOT/kurento-module-creator
./build-kurento-module-creator.sh

#Build kms-jsonrpc
KMS_JSONRPC_DIR=$ROOT/kms-jsonrpc
./build-kms-jsonrpc.sh

KMS_JSONCPP_DIR=$ROOT/jsoncpp

#TODO: allow jsoncpp to be imported locally (maybe add FindKmsJsonCpp file)
LIBRARY_PATH="$KMS_JSONCPP_DIR/src/lib_json";
PKG_CONFIG_PATH="$KMS_JSONCPP_DIR/pkg-config/";

#Replace GST 1.5 version to 1.0 (xenial's default)
find $KMS_CORE_DIR -name CMakeLists.txt -print0 | xargs -0 sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g"

# RENAME is needed to make plugin's name matches filename, according to
# http://gstreamer-devel.966125.n4.nabble.com/Plugin-loading-fails-with-Gstreamer-1-14-0-td4686497.html
#Replace libkmscoreplugins.so to libkmscore.so (This should be commited directly to kms-core)
find $KMS_CORE_DIR -name CMakeLists.txt -print0 | xargs -0 sed -i -e "s/\${LIBRARY_NAME}plugins/\${LIBRARY_NAME}/g"

sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g" $KMS_CORE_DIR/debian/control
sed -i -e "s/gst\([a-zA-Z0-9-]*\)1.5/gst\11.0/g" $KMS_CORE_DIR/debian/kms-core.install

#Build kms-core
cd $KMS_CORE_DIR

CMAKE_MODULE_PATH="$KMS_CMAKE_UTILS_DIR;$KMS_CMAKE_UTILS_DIR/CMake;$KURENTO_MODULE_CREATOR_DIR/classes;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_JSONCPP_DIR;$KMS_JSONCPP_DIR/src";
CMAKE_PREFIX_PATH="$KURENTO_MODULE_CREATOR_DIR;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_JSONRPC_DIR/src/jsonrpc;$KMS_JSONCPP_DIR;$KMS_JSONCPP_DIR/src";
CMAKE_INSTALL_LIBDIR="lib/x86_64-linux-gnu"
CMAKE_INSTALL_PREFIX="/usr"
CMAKE_CXX_FLAGS=" -I$KMS_JSONCPP_DIR/include -L$KMS_JSONCPP_DIR/src/lib_json"

#Parei no module Creator, ele ta gerando um FindKMSCore com o build path alterado
env PKG_CONFIG_PATH=$PKG_CONFIG_PATH cmake -DCMAKE_MODULE_PATH=$CMAKE_MODULE_PATH -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH -DCMAKE_INSTALL_LIBDIR=$CMAKE_INSTALL_LIBDIR -DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS"

env LD_LIBRARY_PATH=$LIBRARY_PATH LIBRARY_PATH=$LIBRARY_PATH make

#Run Tests
#env LD_LIBRARY_PATH=$LIBRARY_PATH make check
cd $ROOT
