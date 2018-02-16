#!/bin/bash

sudo apt-get install -y git
KURENTO_URL=https://github.com/Kurento
KURENTO_VERSION=master

#gstreamer
git clone $KURENTO_URL/gstreamer
cd gstreamer
git checkout $KURENTO_VERSION
cd ..

#gstreamer plugins
for plugin in plugins-base plugins-good libav plugins-ugly plugins-bad
do
  git clone $KURENTO_URL/gst-$plugin
  cd gst-$plugin
  git checkout $KURENTO_VERSION
  cd ..
done

