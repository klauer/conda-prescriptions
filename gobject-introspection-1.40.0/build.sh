#! /bin/bash

# ref: https://binstar.org/pkgw/gobject-introspection
set -e

if [ "$(uname)" == "Darwin" ]; then
    # TODO
    # export LIBFFI_CFLAGS="-I/usr/local/Cellar/libffi/3.0.13/include"
    # export LIBFFI_LIBS="-lffi -L/usr/local/Cellar/libffi/3.0.13/lib/"

    # or using pkgconfig, which requires brew/etc to have installed it
    export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.0.13/lib/pkgconfig/
    export PATH=$PREFIX/bin:$PATH
fi

./configure --prefix=$PREFIX || { cat config.log ; exit 1 ; }
make
make install

