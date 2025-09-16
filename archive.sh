#!/bin/bash

#archive.sh

# This script creates a backup of a specified directory

print_help(){
    echo "Usage: $0 [options] <source_directory> <target_directory>"
    echo "Creates a timestamped backup of a source directory."
    echo "Options:"
    echo "  -h, --help            Show this help message and exit."
    echo "  <source_directory>    The directory to be backed up."
    echo "  <target_directory>    The directory for the backup."
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    print_help
    exit 0
fi

if [[ $# -ne 2 ]]; then
  echo "Error: Invalid number of arguments."
  print_help
  exit 1
fi