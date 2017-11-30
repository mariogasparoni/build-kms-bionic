#!/bin/bash


#Build kurento-module-creator
ROOT=`pwd`
KURENTO_MODULE_CREATOR_DIR=$ROOT/kurento-module-creator
cd $KURENTO_MODULE_CREATOR_DIR
mvn package -DskipTests -DbuildDirectory=$KURENTO_MODULE_CREATOR_DIR

cp scripts/kurento-module-creator .
touch kurento-module-creator.generated

#Without the following replacement, other modules will use the wrong
#path when looking for this module
#this should be a patch, i guess
sed -i 's/PATH_SUFFIXES//g' src/main/cmake/FindKurentoModuleCreator.cmake
sed -i 's/scripts//g' src/main/cmake/FindKurentoModuleCreator.cmake

#Change template for correct path when loooking for cmake modules locally
#this should set correct path for finder files (FindYYY.cmake file)
#
sed -i 's/_BINARY_DIR_PREFIX\ \"build\"/_BINARY_DIR_PREFIX\ \"\"/g' src/main/templates/cpp_find_cmake/model_find_cmake.ftl
cd $ROOT
