## Build Kurento Media Server and it's modules locally
This is intended to be used by developers who wants to develop without
system-wide/apt installing Kurento Media Server and it's libs.
Currently, this works in Ubuntu 16.04 64Bits (Xenial) and uses GStreamer from Ubuntu
official repositories

### Build Kurento Media Server
```bash
./build-kurento.sh
```

### Running Kurento Media Server
```bash
./run-kurento.sh
```

### Build kms-core module only (for the first time or after CMake's changes)
```bash
./build-kms-core.sh
./build-kms-config.sh
```

### Build/run kms-core after changes in source code
```
cd kms-core
... (do modifications) ...
make
cd ..
./run-kurento.sh
```

### Build kms-elements module only (for the first time or after CMake's changes)
(depends on kms-core's module build)
```bash
./build-kms-elements.sh
./build-kms-config.sh
```

### Build/run kms-elements after changes in source code
```
cd kms-elements
... (do modifications) ...
make
cd ..
./run-kurento.sh
```

#### Freely Distributed under the MIT License
