#!/bin/bash

set -xe

ROOT=`pwd`
KMS_CMAKE_UTILS_DIR=$ROOT/kms-cmake-utils
KMS_JSONRPC_DIR=$ROOT/kms-jsonrpc
KMS_JSONCPP_DIR=$ROOT/jsoncpp


#Build jsoncpp
./build-kms-jsoncpp.sh

LIBRARY_PATH="$KMS_JSONCPP_DIR/src/lib_json";
CMAKE_MODULE_PATH="$KMS_CMAKE_UTILS_DIR;$KMS_CMAKE_UTILS_DIR/CMake";

cd $KMS_JSONRPC_DIR
cmake -DCMAKE_MODULE_PATH=$CMAKE_MODULE_PATH
env LIBRARY_PATH=$LIBRARY_PATH make

#You can system-wide install , or point this path to your app's CMAKE
#echo 'You can now make install ...';
#sudo make install
