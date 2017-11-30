#!/bin/bash

#Build kms-cmake-utils

ROOT=`pwd`
KMS_CMAKE_UTILS_DIR=$ROOT/kms-cmake-utils
cd $KMS_CMAKE_UTILS_DIR
cmake .
cd $ROOT
