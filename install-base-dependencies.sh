#!/bin/bash
sudo apt-get update && sudo apt-get install --no-install-recommends -y\
  build-essential cmake debhelper libboost-all-dev\
  binutils pkg-config libboost-dev libboost-regex-dev libboost-system-dev\
  libboost-filesystem-dev libboost-program-options-dev libboost-test-dev\
  libboost-thread-dev libboost-log-dev libevent-dev libssl-dev\
  git openjdk-8-jdk ca-certificates-java maven libsigc++-2.0-dev libglibmm-2.4-dev uuid-dev\
  libgnutls28-dev libwebsocketpp-dev libvpx-dev wget libgstreamer1.0-dev\
  libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev\
  libgstreamer-plugins-bad1.0-dev\
  gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad\
  gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-nice
