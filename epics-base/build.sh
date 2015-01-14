#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    echo "Setting OSX DYLD_FALLBACK_LIBRARY_PATH"
    export DYLD_FALLBACK_LIBRARY_PATH="$PREFIX/lib"
    # TODO cp flags differ, -P is default with -r, but can't be specified somehow
    CP_FLAGS="-rv"
    HOST_ARCH=darwin-x86
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    CP_FLAGS="-Prv"
    HOST_ARCH=linux-x86
fi

make -j$(getconf _NPROCESSORS_ONLN)
EPICS_BASE=$PREFIX/lib/epics

install -d $PREFIX/lib
cp $CP_FLAGS lib/$HOST_ARCH/* $PREFIX/lib

install -d $PREFIX/bin
cp $CP_FLAGS bin/$HOST_ARCH/caget $PREFIX/bin
cp $CP_FLAGS bin/$HOST_ARCH/caput $PREFIX/bin
cp $CP_FLAGS bin/$HOST_ARCH/camonitor $PREFIX/bin
cp $CP_FLAGS bin/$HOST_ARCH/caRepeater $PREFIX/bin
cp $CP_FLAGS bin/$HOST_ARCH/softIoc $PREFIX/bin

for X in bin configure db dbd include lib startup templates; do
  install -d $EPICS_BASE/$X
  cp $CP_FLAGS $X/* $EPICS_BASE/$X
done
