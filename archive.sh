#!/bin/bash

#archive.sh

# This script creates a backup of a specified directory

log_file="archive.log"
log(){
    local level="$1"
    local message="$*"
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    line="${level}: [${timestamp}] ${message}"
    if [[ "$level" == "ERROR" ]]; then
        echo "$line" | tee -a "$log_file" >&2
    else
        echo "$line" | tee -a "$log_file"
    fi
}

print_help(){
    echo "Usage: $0 [options] <source_directory> <target_directory>"
    echo "Creates a timestamped compressed archive of a source directory."
    echo "Options:"
    echo "  -h, --help            Show this help message and exit."
    echo "  <source_directory>    The directory to be backed up."
    echo "  <target_directory>    The directory for the backup."
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    print_help
    exit 0
fi

dry_run=false
index=()
for arg in "$@"; do
    case $arg in
        -h|--help)
            print_help
            exit 0;;
        -d|--dry-run)
            dry_run=true;;
        *)
            index+=("$arg");;
    esac
done 

config="./archive.conf"
if [[ -f "$config" ]]; then
    source "$config"
else
    log "ERROR" "Configuration file '$config' not found. Exiting."
    exit 1
fi

if [[ ${#index[@]} -ge 1 ]]; then
    source="${index[0]}"
fi
if [[ ${#index[@]} -ge 2 ]]; then
    target="${index[1]}"
fi

if [[ -z "$source" || -z "$target" ]]; then
    log "ERROR" "Source and target directories were not specified. Exiting."
    exit 1
fi

log "INFO" "archive script started."

if [[ ! -d "$source" || ! -r "$source" ]]; then
    log "ERROR" "Source directory '$source' does not exist or is not readable. Exiting." 
    exit 1
fi


if [[ ! -d "$target" ]]; then
    if ! mkdir -p "$target"; then
        log "ERROR" "Target directory '$target' does not exist or could not be created. Exiting."
        exit 1
    fi
fi

timestamp=$(date +"%Y%m%d_%H%M%S")
backup="${target}/backup_${timestamp}.tar.gz"

ignore=".bassignore"
ignore_args=()
if [[ -f "$ignore" ]]; then
    while IFS= read -r pattern || [[ -n "$pattern" ]]; do
        ignore_args+=("--exclude=$pattern")
    done < "$ignore"
fi

log "INFO" "Backing up from $source to $backup."

if [[ "$dry_run" == true ]]; then
    if ! tar -C "$source" --exclude-from="$ignore" -cf /dev/null -v .; then
        log "ERROR" "Dry-run failed. Could not list backup contents."
        exit 1
    fi
else
    if tar -C "$source" --exclude-from="$ignore" -czf "$backup" .; then
        log "INFO" "Backup created successfully."
    else
        log "ERROR" "Failed to create backup."
        exit 1
    fi

fi
# echo "Backing up '$source' to '$backup'..."
# rsync -av --progress "$source"/ "$backup"
# echo "Backup complete."

exit 0