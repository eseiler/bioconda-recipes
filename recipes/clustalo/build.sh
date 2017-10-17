#!/bin/bash

make
./configure
make install
ls

mkdir -p $PREFIX/bin
cp $SRC_DIR/clustal* $PREFIX/bin/$PKG_NAME
chmod +x $PREFIX/bin/$PKG_NAME
