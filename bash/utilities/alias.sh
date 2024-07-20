#!/bin/bash

# Check if /etc/os-release exists (Ubuntu, Fedora, and others)
if [ -f "/etc/os-release" ]; then
    . /etc/os-release

    # Check the value of the ID variable to determine the Linux distribution
    case "$ID" in
        ubuntu)
            if command -v batcat &> /dev/null; then
                alias cat='batcat'
            fi
            ;;
        fedora)
            if command -v bat &> /dev/null; then
                alias cat='bat'
            fi
            ;;
        *)
            echo "Detected other distribution: $ID"
            ;;
    esac

# Check if /etc/redhat-release exists (Red Hat and CentOS)
elif [ -f "/etc/redhat-release" ]; then
    echo "Detected Red Hat or CentOS"

# Check if /etc/debian_version exists (Debian)
elif [ -f "/etc/debian_version" ]; then
    echo "Detected Debian"

# For other distributions (generic fallback)
else
    echo "Detected an unknown Linux distribution"
fi
