 #!/bin/bash

 set -x
sudo apt-get install -y git
PROJECT_URL=https://github.com/Kurento
KURENTO_BRANCH=6.6.1

#gstreamer
git clone $PROJECT_URL/gstreamer

#gstreamer plugins (system-wide install)
git clone $PROJECT_URL/gst-libav
git clone $PROJECT_URL/gst-plugins-bad
git clone $PROJECT_URL/gst-plugins-base
git clone $PROJECT_URL/gst-plugins-good
git clone $PROJECT_URL/gst-plugins-ugly
git clone $PROJECT_URL/libnice

#kurento deps (system-wide install)
git clone $PROJECT_URL/jsoncpp
git clone $PROJECT_URL/usrsctp
git clone $PROJECT_URL/openwebrtc-gst-plugins
git clone $PROJECT_URL/libsrtp

#kurento modules (all build-locally)
git clone $PROJECT_URL/kms-cmake-utils
git clone $PROJECT_URL/kurento-module-creator
git clone $PROJECT_URL/kms-jsonrpc

#These modules Follow the kurento main version
git clone $PROJECT_URL/kms-core
cd kms-core && git checkout KURENTO_BRANCH

git clone $PROJECT_URL/kms-elements
cd kms-elements && git checkout KURENTO_BRANCH

git clone $PROJECT_URL/kms-filters
cd kms-filters && git checkout KURENTO_BRANCH

#kurento
git clone $PROJECT_URL/kurento-media-server
cd kurento-media-server && git checkout KURENTO_BRANCH
