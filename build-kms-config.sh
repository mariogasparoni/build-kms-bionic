#!/bin/bash

ROOT=`pwd`
KMS_DIR=$ROOT/kurento-media-server
KMS_ELEMENTS_DIR=$ROOT/kms-elements
KMS_CORE_DIR=$ROOT/kms-core

cd $KMS_DIR

# Create path for loading config modules (Kurento currently a subfolder "kurento" inside of the module config path)
# Actually Kurento should load it directly from each folder in the given paths passed
# in 'kurento-media-server -c ...' and not from a subfolder. This might become a patch
# inside Kurento's loadConfig process.
for path in $KMS_CORE_DIR $KMS_ELEMENTS_DIR
do
  mkdir -p $path/modules_config
  ln -sn $path/src/server/config $path/modules_config/kurento -f
done

cd $ROOT
