# autobass
Autobass is a Bash backup script that creates timestamped compressed archives of directories, 
with logging, configuration file support, ignore rules,
and a dry-run mode for safe testing.
Also with help menu

Usage 1: Direct backup
./archive.sh <source_directory> <target_directory>  EX: ./archive.sh ./test_source ./backup_folder


Usage 2: Backup by config file
Edit the file named archive.conf
source=/path/to/source
target=/path/to/backup

Then run
./archive.sh



Dry-run mode
./archive.sh -d <source_directory> <target_directory>



Help
./archive.sh -h

Exclude file
Edit the file named .bassignore
EX: *.log
    *.tmp
