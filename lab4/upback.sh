#!/bin/bash

backupPath=""
backupSec=0
restorePath="$HOME/restore"

for file in $(echo $(ls "$HOME" | grep "Backup-")); do
  date=$(echo $file | awk -F "Backup-" '{print $2}')
  dateSec=$(date -d $date +%s)
  if [[ "$dateSec" -gt "$backupSec" ]]; then
    backupSec=$dateSec
	backupPath="$HOME/$file"
  fi
done

if [[ backupPath != "" ]]; then
  for file in $(echo $(ls "$backupPath" | grep -v -E "[A-Za-z0-9]*.[0-9]{4}-[0-9]{2}-[0-9]{2}")); do
    cp "$backupPath/$file" "$restorePath"
  done
fi
