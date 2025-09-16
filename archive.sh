#!/bin/bash

#archive.sh

# This script creates a backup of a specified directory

print_help(){
    echo "Usage: $0 [options] <source_directory> <target_directory>"
    echo "Options:"
    echo "  -h, --help        Show this help message and exit"
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    print_help
    exit 0
fi