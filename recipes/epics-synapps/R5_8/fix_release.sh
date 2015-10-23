#!/bin/bash

pushd support

echo "Fixing RELEASE files..."
# set the epics base path and synapps path
sed -i 's|^EPICS_BASE\s*=.*$|EPICS_BASE = '$EPICS_BASE'|g' configure/RELEASE
sed -i 's|^SUPPORT\s*=.*$|SUPPORT = '$PWD'|g' configure/RELEASE

declare -a ignore_modules=('IP330' 'IPAC' 'IPUNIDIG'
                           'MODBUS' 'QUADEM' 'DAC128V' 'SOFTGLUE'
                           'DELAYGEN' 'DXP' 'VME'
                           'ALLEN_BRADLEY' 'MCA' 'MEASCOMP')


release_files=$(find . -name RELEASE -type f)

# Don't build hytec motor support
sed -i 's|^.*Hytec.*$||g' motor-*/motorApp/Makefile

for ignore in "${ignore_modules[@]}" 
do
    sed -i 's|^'${ignore}'\s*=|# '${ignore}='|g' ${release_files}
done

echo "Copying RELEASE to subdirectories"
make release

popd
