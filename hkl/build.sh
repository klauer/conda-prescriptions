#! /bin/bash

if [ "$(uname)" == "Darwin" ]; then
    # TODO
    # export LIBFFI_CFLAGS="-I/usr/local/Cellar/libffi/3.0.13/include"
    # export LIBFFI_LIBS="-lffi -L/usr/local/Cellar/libffi/3.0.13/lib/"

    # may not be using brew, but try anyway:
    brew install automake libtool
    # automake required for autoreconf (generating configure files)

    # or using pkgconfig, which requires brew/etc to have installed it
    export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.0.13/lib/pkgconfig/
    export PATH=$PREFIX/bin:$PATH

    export CFLAGS="-I$PREFIX/include -fPIC $CFLAGS"
    export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
    export GLIB_MKENUMS=$PREFIX/bin/glib-mkenums
fi

set -e

test -d m4 || mkdir m4

rm -rf Documentation
autoreconf -ivf

./configure --disable-gui --enable-introspection=yes --prefix=$PREFIX 
# || { cat config.log ; exit 1 ; }
make
make install

