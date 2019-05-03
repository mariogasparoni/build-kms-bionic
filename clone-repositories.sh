 #!/bin/bash

set -x

sudo apt-get install -y git
KURENTO_URL=https://github.com/Kurento
KURENTO_VERSION=master

#kurento deps (system-wide install)
for dep in jsoncpp usrsctp openwebrtc-gst-plugins
do
  git clone $KURENTO_URL/$dep
  cd $dep
  git checkout $KURENTO_VERSION
  cd ..
done;

#kurento modules (all build-locally)
for module in kms-cmake-utils kurento-module-creator kms-jsonrpc
do
  git clone $KURENTO_URL/$module
  cd $module
  git checkout $KURENTO_VERSION
  cd ..
done;

KURENTO_URL=https://github.com/mariogasparoni
KURENTO_VERSION=gstreamer-1.14-bionic
for module in kms-core kms-elements kms-filters
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
