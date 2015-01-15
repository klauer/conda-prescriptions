#!/bin/bash

# usage: activate.sh (conda_bin_path)

read -d '' ADD_VAR <<"EOF"
#!/usr/bin/env python

# add an entry to an environment variable
# usage: () env_var_name delimiter subpath_to_add conda_bin_path
#   subpath is relative to conda_root

from __future__ import print_function
import os
import sys

env_var, delimiter, add_sub_path, conda_bin = sys.argv[1:]
conda_root = os.path.normpath(os.path.join(conda_bin, '..'))

new_path = os.path.join(conda_root, add_sub_path)
cur_value = os.environ.get(env_var, '')

if cur_value:
    cur_values = cur_value.split(delimiter)

    if new_path not in cur_values:
        cur_values.insert(0, new_path)

    print(delimiter.join(cur_values))
else:
    print(new_path)

EOF

add_var() {
    var_name=$1
    add_path=$2
    value=$(python -c "$ADD_VAR" "$var_name" ":" "$add_path" $conda_bin)
    export $var_name=$value
    echo "Setting $var_name = $value"
}

conda_bin=$1

add_var "GI_TYPELIB_PATH" "lib/girepository-1.0"

if [ "$(uname)" == "Darwin" ]; then
    add_var "DYLD_FALLBACK_LIBRARY_PATH" "lib"
else
    add_var "LD_LIBRARY_PATH" "lib"
fi
