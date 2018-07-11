## Build Kurento Media Server and it's modules locally
This is intended to be used by developers who wants to develop without
system-wide/apt installing Kurento Media Server and it's libs.
Currently, this works in Ubuntu 16.04 64Bits (Xenial) and uses GStreamer from Ubuntu
official repositories

### Build Kurento Media Server
```bash
./build-kurento.sh
```
This will clone Kurento repositories from Kurento's Official GitHub and build it

### Running Kurento Media Server
```bash
./run-kurento.sh
```
This will run kurento, loading it's plugins and configs from local build path

### Build kms-core module only (for the first time or after CMake's changes)
```bash
... ( checkout "kms-core" repo to your own repository ) ...
./build-kms-core.sh
./build-kms-config.sh
```
This will build kms-core source files locally (without system-wide installation)

### Build/run kms-core after changes in source code (not CMake's files)
```
cd kms-core
... (do modifications) ...
make
cd ..
./run-kurento.sh
```
Same as before, except it doesn't run CMake

### Build kms-elements module only (for the first time or after CMake's changes)
(depends on kms-core's module build)
```bash
... ( checkout "kms-elements" repo to your own repository ) ...
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
