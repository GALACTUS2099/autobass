#!/bin/bash

#archive.sh

print_help() {
echo "Usage: $0<source_dir> <target_dir>"
echo "Creates a timestamped backup of a source directory."
echo "Options"
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