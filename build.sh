#!/bin/bash

xcodebuild -scheme Clipinio -target Clipinio \
    -configuration Release \
    CONFIGURATION_BUILD_DIR=./build
/bin/cp -r ./build/Clipinio.app /Applications
