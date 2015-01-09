#! /bin/bash

set -e

./configure --prefix=$PREFIX || { cat config.log ; exit 1 ; }
make -j$(getconf _NPROCESSORS_ONLN)
make install

