## Build Kurento Media Server and it's modules locally
This is intended to be used by developers who wants to develop without
system-wide/apt installing Kurento Media Server


### Build GStreamer and make a system-wide installation
Init submodule
```bash
git submodule init
git submodule update
```

To build master version:
```bash
cd build-gstreamer
git checkout kurento
./build-gstreamer.sh
```

To build another revision of GStreamer:
```bash
cd build-gstreamer
git checkout kurento
./build-gstreamer.sh ANOTHER_REVISION
```


### Build Kurento Media Server
```bash
git checkout 6.6.1+_with_latest_gstreamer
./build-kurento.sh
```

### Running Kurento Media Server
```bash
./run-kurento.sh
```

### Build kms-core module only
```bash
git checkout 6.6.1+_with_latest_gstreamer
./build-kms-core.sh
```

### Build kms-elements module only (depends on kms-core's module build)
```bash
git checkout 6.6.1+_with_latest_gstreamer
./build-kms-elements.sh
```

#### Freely Distributed under the MIT License
