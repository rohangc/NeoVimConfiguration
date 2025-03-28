#!/bin/bash

# Determine location of 'init.lua':
if [ -n "$XDG_DATA_HOME" ]; then
    init_lua_dir="$XDG_DATA_HOME/nvim"
else
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        init_lua_dir="$HOME/.config/nvim"
    elif [[ "$OSTYPE" == "msys" ]]; then
        init_lua_dir="$LOCALAPPDATA/nvim"
    else
        echo "Unsupported OS type: $OSTYPE"
        exit 1
    fi
fi

# Create directory if it doesn't already exist
mkdir -p "$init_lua_dir"

# Copy the 'init.lua' file to the appropriate destination
cp -rf ./lua "$init_lua_dir/lua"
cp -f ./init.lua "$init_lua_dir/init.lua"
