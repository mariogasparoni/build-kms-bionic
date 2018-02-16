#!/bin/bash

set -xe
ROOT=`pwd`
KMS_CORE_DIR=$ROOT/kms-core
#Install dependencies
./install-base-dependencies.sh

#Uncoment 'builds' scripts if this is the first time building


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

#TODO: allow jsoncpp to be imported locally (maybe add FindKmsJsonCpp file  )
LIBRARY_PATH="$KMS_JSONCPP_DIR/src/lib_json";

#Build kms-core
cd $KMS_CORE_DIR

CMAKE_MODULE_PATH="$KMS_CMAKE_UTILS_DIR;$KMS_CMAKE_UTILS_DIR/CMake;$KURENTO_MODULE_CREATOR_DIR/classes;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_JSONCPP_DIR;$KMS_JSONCPP_DIR/src";
CMAKE_PREFIX_PATH="$KURENTO_MODULE_CREATOR_DIR;$KMS_JSONRPC_DIR;$KMS_JSONRPC_DIR/src;$KMS_JSONRPC_DIR/src/jsonrpc;$KMS_JSONCPP_DIR;$KMS_JSONCPP_DIR/src";
CMAKE_INSTALL_LIBDIR="lib/x86_64-linux-gnu"
CMAKE_INSTALL_PREFIX="/usr"

#Parei no module Creator, ele ta gerando um FindKMSCore com o build path alterado
cmake -DCMAKE_MODULE_PATH=$CMAKE_MODULE_PATH -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH -DCMAKE_INSTALL_LIBDIR=$CMAKE_INSTALL_LIBDIR -DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX

env LD_LIBRARY_PATH=$LIBRARY_PATH LIBRARY_PATH=$LIBRARY_PATH make

#Run Tests
#env LD_LIBRARY_PATH=$LIBRARY_PATH make check
cd $ROOT
