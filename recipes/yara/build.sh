#!/bin/bash
set -eu -o pipefail

conda update conda-build

BINARY_HOME=$PREFIX/bin
PKG_HOME=$PREFIX/opt/$PKG_NAME-$PKG_VERSION

if [[ "$(uname -s)" == "Linux"* ]]; then
	if grep flags /proc/cpuinfo | grep sse4 > /dev/null; then
		INSTRUCTION=sse4
	else
		INSTRUCTION=x64
	fi
else
	if sysctl -a | grep machdep.cpu.features | grep SSE4 > /dev/null; then
		INSTRUCTION=sse4
	else
		INSTRUCTION=x64
	fi
fi

binaries="\
yara_mapper \
yara_indexer \
"

mkdir -p $PREFIX/bin
mkdir -p $PKG_HOME

ls $SRC_DIR/
ls $SRC_DIR/..

for i in $binaries; do cp $SRC_DIR/$INSTRUCTION/bin/$i $PKG_HOME/$i && chmod a+x $PKG_HOME/$i && ln -s $PKG_HOME/$i $BINARY_HOME/$i; done
