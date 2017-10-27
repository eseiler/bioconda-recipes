#!/bin/bash

sed -i 's/set (CMAKE_MODULE_PATH/# set (CMAKE_MODULE_PATH/' CMakeLists.txt
sed -i 's/set (SEQAN_INCLUDE_PATH "\/usr\/local\/lib\/seqan\/include\/")/set (SEQAN_INCLUDE_PATH "'$(sed 's=/=\\/=g' <<< $PREFIX)'\/include\/seqan")/' CMakeLists.txt
mkdir build 
cd build
cmake ..
make

mkdir -p $PREFIX/bin
cp $SRC_DIR/build/hilive-build $PREFIX/bin/
cp $SRC_DIR/build/hilive $PREFIX/bin/
cp $SRC_DIR/build/hilive-out $PREFIX/bin/

chmod +x $PREFIX/bin/hilive*
