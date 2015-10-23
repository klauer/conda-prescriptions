#!/bin/bash

cp ${RECIPE_DIR}/CONFIG_SITE.local support/configure

pushd support/areaDetector-*

cp ${RECIPE_DIR}/CONFIG_SITE.local configure/CONFIG_SITE.local.${EPICS_HOST_ARCH}

popd
