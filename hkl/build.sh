#! /bin/bash

set -e

test -d m4 || mkdir m4

# autoreconf -ivf --prepend-include=$PREFIX/share/aclocal
./autogen.sh

./configure --disable-gui --enable-introspection=yes --disable-hkl-doc --prefix=$PREFIX 
# || { cat config.log ; exit 1 ; }
make
make install

