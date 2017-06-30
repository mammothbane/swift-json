#!/usr/bin/env sh

set -e

cd jsmn
make
cd ..

swift build -Xlinker -Ljsmn

