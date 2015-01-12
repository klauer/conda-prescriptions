#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    echo "Setting OSX DYLD_FALLBACK_LIBRARY_PATH"
    export DYLD_FALLBACK_LIBRARY_PATH="$PREFIX/lib"
    # TODO cp flags differ, -P is default with -r, but can't be specified somehow
    CP_FLAGS="-rv"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    CP_FLAGS="-Prv"
fi

make -j$(getconf _NPROCESSORS_ONLN)
EPICS_BASE=$PREFIX/lib/epics

install -d $PREFIX/lib
cp $CP_FLAGS lib/darwin-x86/* $PREFIX/lib

install -d $PREFIX/bin
cp $CP_FLAGS bin/darwin-x86/caget $PREFIX/bin
cp $CP_FLAGS bin/darwin-x86/caput $PREFIX/bin
cp $CP_FLAGS bin/darwin-x86/camonitor $PREFIX/bin
cp $CP_FLAGS bin/darwin-x86/caRepeater $PREFIX/bin
cp $CP_FLAGS bin/darwin-x86/softIoc $PREFIX/bin

for X in bin configure db dbd include lib startup templates; do
  install -d $EPICS_BASE/$X
  cp $CP_FLAGS $X/* $EPICS_BASE/$X
done
