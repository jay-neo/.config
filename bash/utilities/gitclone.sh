#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <repo>"
    exit 1
fi

# Get the username and repo from command line arguments
username="$1"
repo="$2"

# Clone the repository
git clone "https://github.com/$username/$repo.git"

# Change directory to the cloned repository
cd "$repo"

# Change permissions (chmod) of the repository to 755 (drwxr-xr-x)
chmod -R 754 .

echo "Cloned $repo and changed all permissions successfully."
