#!/bin/bash

ROOT=`pwd`
KMS_JSONCPP_DIR=$ROOT/jsoncpp

#Build jsoncpp
cd $KMS_JSONCPP_DIR
#jsoncpp must be built as a shared lib
cmake -DBUILD_SHARED_LIBS="ON" .
make
cd $ROOT
