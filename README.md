## Build Kurento Media Server and it's modules locally
This is intended to be used by developers who wants to develop without
system-wide/apt installing Kurento Media Server


### Build GStreamer and make a system-wide installation
```bash
./build-libgstreamer.sh
```

### Build Kurento Media Server
```bash
./build-kurento.sh
```

### Running Kurento Media Server
```bash
./run-kurento.sh
```

### Build kms-core module only
```bash
./build-kms-core.sh
```

### Build kms-elements module only (depends on kms-core's module build)
```bash
./build-kms-elements.sh
```

#### Freely Distributed under the MIT License
