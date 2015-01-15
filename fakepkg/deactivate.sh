#!/bin/bash

read -d '' REM_VAR <<"EOF"
#!/usr/bin/env python

# remove an entry from an environment variable
# usage: () env_var_name delimiter subpath_to_remove conda_bin_path
#   subpath is relative to conda_root

from __future__ import print_function
import os
import sys

env_var, delimiter, rem_sub_path, conda_bin = sys.argv[1:]
conda_root = os.path.normpath(os.path.join(conda_bin, '..'))

new_path = os.path.join(conda_root, rem_sub_path)
value = os.environ.get(env_var, '')

if value:
    values = value.split(delimiter)
    
    if new_path in values:
        values.remove(new_path)

    print(delimiter.join(values))
else:
    print('')

EOF


rem_var() {
    var_name=$1
    add_path=$2
    value=$(python -c "$REM_VAR" "$var_name" ":" "$add_path" $conda_bin)
    export $var_name=$value
    echo "Setting $var_name = $value"
}

conda_bin=$1

rem_var "GI_TYPELIB_PATH" "lib/girepository-1.0"

if [ "$(uname)" == "Darwin" ]; then
    rem_var "DYLD_FALLBACK_LIBRARY_PATH" "lib"
else
    rem_var "LD_LIBRARY_PATH" "lib"
fi
