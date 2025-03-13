#!/bin/bash
if [[ -z "$1" ]];then
  echo "you have not enter directory path"
  exit 1
fi

CURR_DIR="$1" #path provided by user whose backup needs to take
BACKUP_ROOT="backup"  #where we will store backup
Time_stamp=$(date +"%y%m%d_%H%M%S")
new_dir="${BACKUP_ROOT}/backup_${Time_stamp}"

mkdir -p "$BACKUP_ROOT"

if [[ ! -d "$CURR_DIR" ]];then
  echo "error:SOURCE doesn't exist"
  exit 1
fi

cp -r "$CURR_DIR" "$new_dir"

BACKUPS= ls -d "$BACKUP_ROOT" || sort

cd "$BACKUP_ROOT" || exit
BACKUPS=($(ls -d backup_* | sort))

count=${#BACKUPS[@]}
if [[ "$count" -gt 3 ]]; then
num_delete=$count-3
for((i=0; i<num_delete; i++));do
rm -rf "${BACKUPS[i]}"
done
fi






