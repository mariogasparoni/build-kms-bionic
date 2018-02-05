 #!/bin/bash

set -x

sudo apt-get install -y git
KURENTO_URL=https://github.com/Kurento
KURENTO_VERSION=master

#kurento deps (system-wide install)
for dep in jsoncpp usrsctp openwebrtc-gst-plugins libsrtp
do
  git clone $KURENTO_URL/$dep
  cd $dep
  git checkout $KURENTO_VERSION
  cd ..
done;

#kurento modules (all build-locally)
for module in kms-cmake-utils kurento-module-creator kms-jsonrpc kms-core kms-elements kms-filters
do
  git clone $KURENTO_URL/$module
  cd $module
  git checkout $KURENTO_VERSION
  cd ..
done;

#kurento media server
git clone $KURENTO_URL/kurento-media-server
cd kurento-media-server && git checkout $KURENTO_VERSION
cd ..
