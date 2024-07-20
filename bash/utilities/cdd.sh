#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Please provide a directory name as an argument."
    exit 1
fi

folder_name="$1"

# Default permission mode
permission_mode="750"  

# Check if a permission mode is provided as an argument
if [ $# -eq 2 ] && [[ $2 =~ ^[0-9]+$ ]]; then
    permission_mode="$2"
fi


# Check if the folder exists
if [ ! -d "$folder_name" ]; then
    echo "'$folder_name' is newly created."
    mkdir -m "$permission_mode" -p "$folder_name"
fi

# Enter into the folder
cd "$folder_name" || exit 1

