#!/bin/bash

ROOT=`pwd`
KMS_DIR=$ROOT/kurento-media-server
KMS_ELEMENTS_DIR=$ROOT/kms-elements
KMS_CORE_DIR=$ROOT/kms-core
KMS_FILTERS_DIR=$ROOT/kms-filters
KMS_CMAKE_UTILS_DIR=$ROOT/kms-cmake-utils
KURENTO_MODULE_CREATOR_DIR=$ROOT/kurento-module-creator
KMS_JSONRPC_DIR=$ROOT/kms-jsonrpc
KMS_JSONCPP_DIR=$ROOT/jsoncpp

./install-base-dependencies.sh

#Get source code
./clone-repositories.sh

#Uncoment 'builds' scripts if this is the first time building
#build kms-core
./build-kms-core.sh

#build kms-elements
./build-kms-elements.sh

#build kms-filters
./build-kms-filters.sh


cd $KMS_DIR
#we may dont need env command

KURENTO_MODULES_DIR="$KMS_CORE_DIR/src/server/kmd;$KMS_ELEMENTS_DIR/src/server/kmd;$KMS_FILTERS_DIR/src/server/kmd";
CMAKE_MODULE_PATH="$KMS_CMAKE_UTILS_DIR;$KMS_CMAKE_UTILS_DIR/CMake;$KURENTO_MODULE_CREATOR_DIR/classes;$KMS_CORE_DIR;$KMS_CORE_DIR/CMake;$KMS_CORE_DIR/src/server;$KMS_CORE_DIR/src/gst-plugins;$KMS_CORE_DIR/src/gst-plugins/commons;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_ELEMENTS_DIR/src/server"
CMAKE_PREFIX_PATH="$KURENTO_MODULE_CREATOR_DIR;$KMS_CORE_DIR;$KMS_CORE_DIR/src/server;$KMS_CORE_DIR/src/gst-plugins;$KMS_CORE_DIR/src/gst-plugins/commons;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_JSONRPC_DIR/src/jsoncpp;$KMS_ELEMENTS_DIR";
LIBRARY_PATH="$KMS_JSONCPP_DIR/src/lib_json";

#CMAKE_MODULE_PATH="$KMS_CORE_DIR/CMake;$KMS_CMAKE_UTILS_DIR;$KMS_CMAKE_UTILS_DIR/CMake;$KURENTO_MODULE_CREATOR_DIR/classes;$KMS_JSONRPC_DIR;$KMS_CORE_DIR;$KMS_CORE_DIR/src/server;$KMS_ELEMENTS_DIR;$KMS_ELEMENTS_DIR/src/server;$KMS_FILTERS_DIR;$KMS_FILTERS_DIR/src/server";
#CMAKE_PREFIX_PATH="$KMS_CORE_DIR/src/gst-plugins/commons;$KMS_CORE_DIR/src/gst-plugins/commons/CMakeFiles;$KURENTO_MODULE_CREATOR_DIR;$KMS_CORE_DIR;$KMS_CORE_DIR/src/server;$KMS_ELEMENTS_DIR;$KMS_ELEMENTS_DIR/src/server;$KMS_FILTERS_DIR;$KMS_FILTERS_DIR/src/server;";
env KURENTO_MODULES_DIR=$KURENTO_MODULES_DIR cmake -DCMAKE_MODULE_PATH=$CMAKE_MODULE_PATH -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH . ;
env LIBRARY_PATH=$LIBRARY_PATH make
cd $ROOT
