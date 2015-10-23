#!/bin/bash

set +e

source $PREFIX/etc/conda/activate.d/epics_base.sh

echo "EPICS_BASE=$EPICS_BASE"
echo "CPU_COUNT=$CPU_COUNT"

cd support

< fix_release.sh
< fix_areadetector.sh

make -j $CPU_COUNT
make

# install this way because I can't figure out how to do it properly

find . -type f -name "*.a" -exec cp {} $PREFIX/epics/lib/$EPICS_HOST_ARCH/ \;
find . -type f -name "*.so" -exec cp {} $PREFIX/epics/lib/$EPICS_HOST_ARCH/ \;
find . -type d -name "dbd" -exec /bin/bash -c "cp {}/*.dbd $PREFIX/epics/dbd" \;
find . -type d -name "db" -exec /bin/bash -c "cp {}/*.db $PREFIX/epics/db" \;
find . -type d -wholename "*bin/$EPICS_HOST_ARCH" -exec /bin/bash -c "cp {}/* $PREFIX/epics/bin" \;
