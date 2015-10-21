#!/bin/bash

set +e

env
#EPICS_BASE=$PREFIX/epics
export EPICS_BASE=$PREFIX/epics
export EPICS_HOST_ARCH=linux-x86_64


echo $EPICS_BASE
echo $EPICS_HOST_ARCH

cd support
echo "where is the source being extracted?"
pwd

# set epics base
sed -i 's|^EPICS_BASE\s*=.*$|EPICS_BASE = '$EPICS_BASE'|g' configure/RELEASE

# set epics base
sed -i 's|^SUPPORT\s*=.*$|SUPPORT = '$PWD'|g' configure/RELEASE

sed -i 's|^AREA_DETECTOR|# AREA_DETECTOR|g' configure/RELEASE
sed -i 's|^ADCORE|# ADCORE|g' configure/RELEASE
sed -i 's|^ADBINARIES|# ADBINARIES|g' configure/RELEASE
sed -i 's|^IP330|# IP330|g' configure/RELEASE
sed -i 's|^IPAC|# IPAC|g' configure/RELEASE
sed -i 's|^IPUNIDIG|# IPUNIDIG|g' configure/RELEASE
sed -i 's|^MODBUS|# MODBUS|g' configure/RELEASE
sed -i 's|^QUADEM|# QUADEM|g' configure/RELEASE
sed -i 's|^SSCAN|# SSCAN|g' configure/RELEASE
sed -i 's|^DAC128V|# DAC128V|g' configure/RELEASE
sed -i 's|^SOFTGLUE|# SOFTGLUE|g' configure/RELEASE
sed -i 's|^DELAYGEN|# DELAYGEN|g' configure/RELEASE
sed -i 's|^DXP|# DXP|g' configure/RELEASE
sed -i 's|^VME|# VME|g' configure/RELEASE
sed -i 's|^ALLEN_BRADLEY|# ALLEN_BRADLEY|g' configure/RELEASE
sed -i 's|^MCA|# MCA|g' configure/RELEASE
sed -i 's|^MEASCOMP|# MEASCOMP|g' configure/RELEASE

sed -i 's|^SSCAN|# SSCAN|g' calc-*/configure/RELEASE
sed -i 's|^IPAC|# IPAC|g' asyn-*/configure/RELEASE
sed -i 's|^IPAC|# IPAC|g' motor-*/configure/RELEASE

sed -i 's|^.*Hytec.*$||g' motor-*/motorApp/Makefile

rm -rf areaDetector* ADCore* ADBin* ip330* ipac* ipUnidig* modbus* quadEM* sscan*
rm -rf dac128* softGlue* delaygen* dxp* vme* allenBradley* mca* measComp*

make release
echo "make release done"
make -j30
echo "parallel build completed"
make
echo "other build completed"
