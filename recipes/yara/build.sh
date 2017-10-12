#!/bin/bash
set -e

cd $SRC_DIR
mkdir yara_build
cd yara_build
export PATH_BACKUP=$PATH
if (( $ARCH == 64 )) ; then
	env -i PATH="$PATH" CXX="$CXX" cmake .. -DSEQAN_BUILD_SYSTEM=APP:yara -DSEQAN_STATIC_APPS=1 -DSEQAN_ARCH_SSE4=1 -DCMAKE_CXX_COMPILER=$CXX
else
	env -i PATH="$PATH" CXX="$CXX" cmake .. -DSEQAN_BUILD_SYSTEM=APP:yara -DSEQAN_STATIC_APPS=1 -DCMAKE_CXX_FLAGS="-m32" -DCMAKE_CXX_COMPILER=$CXX
fi	
make all
export PATH=$PATH_BACKUP

binaries="\
yara_mapper \
yara_indexer \
"

BINARY_HOME=$PREFIX/bin
PKG_HOME=$PREFIX/opt/$PKG_NAME-$PKG_VERSION

mkdir -p $PREFIX/bin
mkdir -p $PKG_HOME

for i in $binaries; do cp $SRC_DIR/yara_build/bin/$i $PKG_HOME/$i && chmod a+x $PKG_HOME/$i && ln -s $PKG_HOME/$i $BINARY_HOME/$i; done
