#!/bin/bash

set +e

source $PREFIX/etc/conda/activate.d/epics_base.sh
source ${RECIPE_DIR}/fix_areadetector.sh
source ${RECIPE_DIR}/fix_release.sh

pushd support
make -j $CPU_COUNT
make
popd

# install this way because I can't figure out how to do it properly

# shared/static libraries
find . -type f -name "*.a" -exec cp {} $PREFIX/epics/lib/$EPICS_HOST_ARCH/ \;
find . -type f -name "*.so" -exec cp {} $PREFIX/epics/lib/$EPICS_HOST_ARCH/ \;
# database definitions
find . -type d -name "dbd" -exec /bin/bash -c "cp {}/*.dbd $PREFIX/epics/dbd" \;
# database files
find . -type d -name "db" -exec /bin/bash -c "cp {}/*.db $PREFIX/epics/db" \;
# binaries
find . -type d -wholename "*bin/$EPICS_HOST_ARCH" -exec /bin/bash -c "cp {}/* $PREFIX/epics/bin/$EPICS_HOST_ARCH" \;
# include files
find . -type d -name "include" -exec /bin/bash -c "cp {}/* $PREFIX/epics/include" \;
